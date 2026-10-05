import assert from 'node:assert/strict';
import {spawn, spawnSync} from 'node:child_process';
import {readFile} from 'node:fs/promises';
import {mkdtemp, rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import test from 'node:test';
import {setTimeout as delay} from 'node:timers/promises';

const packageRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const observerDartPath = path.join(packageRoot, 'lib/src/observer/portal_browser_observer.dart');
const observerDart = await readFile(observerDartPath, 'utf8');
const observerMatch = observerDart.match(/static const String _observerScript = r'''([\s\S]*?)''';/);
assert.ok(observerMatch, 'The fixed observer JavaScript must remain available as a Dart raw string.');
const observerScript = observerMatch[1];
const firefoxAvailable = spawnSync('firefox', ['--version'], {encoding: 'utf8'}).status === 0;

test('fixed observer reads visible tables, rejects auth pages, and follows SPA/full loads', {
  skip: !firefoxAvailable && 'Firefox is not installed; run with Firefox available to execute the DOM fixture.',
  timeout: 30000,
}, async () => {
  const profile = await mkdtemp(path.join(tmpdir(), 'magnet-firefox-'));
  const port = 6200 + Math.floor(Math.random() * 500);
  const browser = spawn('firefox', [
    '--headless', '--no-remote', '--profile', profile,
    `--remote-debugging-port=${port}`, 'about:blank',
  ], {stdio: ['ignore', 'pipe', 'pipe']});
  let browserOutput = '';
  browser.stdout.on('data', chunk => browserOutput += chunk.toString());
  browser.stderr.on('data', chunk => browserOutput += chunk.toString());

  let socket;
  let nextId = 0;
  const pending = new Map();
  let contextId;
  const send = (method, params = {}) => new Promise((resolve, reject) => {
    const id = ++nextId;
    pending.set(id, {resolve, reject});
    socket.send(JSON.stringify({id, method, params}));
  });
  const waitFor = async predicate => {
    const deadline = Date.now() + 10000;
    while (!predicate()) {
      if (browser.exitCode !== null) throw new Error(`Firefox exited: ${browserOutput}`);
      if (Date.now() > deadline) throw new Error(`Firefox BiDi did not start: ${browserOutput}`);
      await delay(50);
    }
  };
  const openWebSocket = async () => {
    await waitFor(() => browserOutput.includes(`ws://127.0.0.1:${port}`));
    socket = new WebSocket(`ws://127.0.0.1:${port}/session`);
    socket.onmessage = ({data}) => {
      const message = JSON.parse(data);
      const request = pending.get(message.id);
      if (!request) return;
      pending.delete(message.id);
      if (message.type === 'error') request.reject(new Error(message.message));
      else request.resolve(message.result);
    };
    socket.onerror = () => {
      for (const request of pending.values()) request.reject(new Error('Firefox WebSocket failed'));
      pending.clear();
    };
    await new Promise((resolve, reject) => {
      socket.addEventListener('open', resolve, {once: true});
      socket.addEventListener('error', reject, {once: true});
    });
    await send('session.new', {capabilities: {}});
    const tree = await send('browsingContext.getTree');
    contextId = tree.contexts[0].context;
  };
  const navigate = async html => {
    const url = `data:text/html;charset=utf-8,${encodeURIComponent(html)}`;
    await send('browsingContext.navigate', {context: contextId, url, wait: 'complete'});
  };
  const evaluate = async expression => {
    const response = await send('script.evaluate', {
      expression,
      target: {context: contextId},
      awaitPromise: true,
      resultOwnership: 'none',
    });
    if (response.exceptionDetails) throw new Error(response.exceptionDetails.text);
    return response.result.value;
  };
  const page = (body, title = 'Course Portal') => `<!doctype html><html lang="en"><head><title>${title}</title></head><body>
    <script>window.__observerMessages=[];window.flutter_inappwebview={callHandler:(name,snapshot,truncated)=>window.__observerMessages.push({name,snapshot,truncated})};</script>
    ${body}<script>${observerScript}</script><script>window.__magnetPortalPushState = history.pushState;</script></body></html>`;
  const captureExpression = 'JSON.stringify(window.__magnetPortalCapture())';
  const injectAgain = `(${observerScript})`;

  try {
    await openWebSocket();
    const navLinks = Array.from({length: 90}, (_, index) => `<a href="/records/${index}?token=private">Portal link ${index}</a>`).join('');
    const courseRows = Array.from({length: 65}, (_, index) => `<tr><td>CS${100 + index}</td><td>Course ${index}</td></tr>`).join('');
    await navigate(page(`
      <h1>Courses</h1>
      <h2>Current term</h2>
      <nav>${navLinks}<a href="/records?studentId=7654321">Roster</a></nav>
      <table id="courses"><thead><tr><th>Course code</th><th>Course name</th></tr></thead><tbody>${courseRows}</tbody></table>
      <table id="hidden" style="display:none"><tr><th>Hidden secret</th></tr><tr><td>must not appear</td></tr></table>
      <table id="roster"><tr><th>Student Name</th><th>Grade</th></tr><tr><td>Ada Lovelace</td><td>A</td></tr></table>
      <table id="ambiguous"><tbody><tr><td>CS301</td><td>Monday</td></tr><tr><td>CS302</td><td>Tuesday</td></tr></tbody></table>
      <table id="grouped">
        <thead>
          <tr><th rowspan="2">Course code</th><th colspan="2">Meeting</th><th rowspan="2">Room</th></tr>
          <tr><th>Day</th><th>Time</th></tr>
        </thead>
        <tbody>
          <tr><td colspan="4">Fall course offerings</td></tr>
          <tr><td>CS215</td><td>Monday</td><td>09:00</td><td>Hall A</td></tr>
          <tr><td colspan="4">Total: 1 course</td></tr>
          <tr><td>Total</td><td></td><td></td><td></td></tr>
          <tr><td>CS216</td><td>Tuesday</td><td>10:00</td></tr>
          <tr><td>CS217</td><td>Wednesday</td><td>11:00</td><td>Hall B</td></tr>
        </tbody>
        <tfoot><tr><td colspan="4">End of results</td></tr></tfoot>
      </table>
      <input name="studentNumber" value="7654321">
    `));
    const first = JSON.parse(await evaluate(captureExpression));
    assert.equal(first.nodes.some(node => node.kind === 'heading' && node.label === 'Courses'), true);
    const courseTable = first.nodes.find(node => node.kind === 'table');
    assert.ok(courseTable, 'visible table should be captured');
    assert.deepEqual(courseTable.headers, ['Course code', 'Course name']);
    assert.equal(courseTable.rows.length, 60, 'table row count should be capped');
    assert.ok(first.nodes.length <= 80, 'the total snapshot should remain within its node ceiling');
    assert.ok(first.nodes.filter(node => node.kind === 'link').length < 90,
      'link volume should be bounded while the academic table is retained');
    const firstIds = first.nodes.map(node => node.id);
    assert.equal(new Set(firstIds).size, firstIds.length, 'node identifiers should be unique');
    for (let index = 0; index < 20; index++) {
      const repeated = JSON.parse(await evaluate(captureExpression));
      assert.deepEqual(repeated.nodes.map(node => node.id), firstIds, 'unchanged DOM structure must keep node IDs stable');
    }
    const nodesJson = JSON.stringify(first.nodes);
    assert.equal(nodesJson.includes('7654321'), false);
    assert.equal(nodesJson.includes('do-not-read'), false);
    assert.equal(nodesJson.includes('must not appear'), false);
    assert.equal(nodesJson.includes('studentId'), false);
    assert.equal(nodesJson.includes('Ada Lovelace'), false, 'personal name columns must be excluded');
    assert.equal(first.nodes.some(node => node.kind === 'table' && node.label.includes('CS301')), false,
      'tables without an explicit header must be skipped instead of treating the first data row as headers');
    const grouped = first.nodes.find(node => node.kind === 'table' && node.headers.includes('Meeting / Day'));
    assert.ok(grouped, 'grouped and row-spanning headers should produce one logical header per data column');
    assert.deepEqual(grouped.headers, ['Course code', 'Meeting / Day', 'Meeting / Time', 'Room']);
    assert.deepEqual(grouped.rows, [['CS215', 'Monday', '09:00', 'Hall A'], ['CS217', 'Wednesday', '11:00', 'Hall B']]);
    await delay(800);
    const initialMessages = JSON.parse(await evaluate('JSON.stringify(window.__observerMessages)'));
    assert.ok(initialMessages.some(message => message.truncated === true), 'clipped rows or nodes should trigger a generic truncation hint');

    await evaluate(`(() => {
      window.__previousObserver = window.__magnetPortalObserver;
      history.replaceState(null, '', location.href + '#spa');
      const heading=document.createElement('h2');heading.textContent='Updated timetable';document.body.append(heading);
      const row=document.createElement('tr');row.innerHTML='<td>CS202</td><td>Data Systems</td>';document.querySelector('#courses tbody').append(row);
    })()`);
    await delay(850);
    await evaluate(injectAgain); // Simulates native reinjection after an SPA route change.
    const messages = JSON.parse(await evaluate('JSON.stringify(window.__observerMessages)'));
    assert.equal(await evaluate('String(window.__magnetPortalNavigationListeners)'), 'true');
    assert.equal(await evaluate('String(window.__previousObserver !== window.__magnetPortalObserver)'), 'true',
      'SPA URL changes should replace the prior mutation observer');
    assert.equal(await evaluate('String(history.pushState === window.__magnetPortalPushState)'), 'true');
    assert.ok(messages.some(message => message.snapshot.nodes.some(node => node.label === 'Updated timetable')),
      'MutationObserver should publish settled SPA DOM changes through the bridge');

    await navigate(page(`<nav>${navLinks}</nav>
      <table><tr><th>Course code</th><th>Course name</th></tr><tr><td>CS101</td><td>Algorithms</td></tr></table>
      ${Array.from({length: 30}, () => '<table><tr><td>Layout content</td></tr></table>').join('')}`));
    const menuHeavy = JSON.parse(await evaluate(captureExpression));
    assert.equal(menuHeavy.nodes.filter(node => node.kind === 'table').length, 1);
    assert.equal(await evaluate('window.__magnetPortalTruncated'), false,
      'bounded navigation links and skipped layout tables must not imply missing course data');

    await navigate(page('<form><h1>Sign in</h1><input name="username"><input type="password" value="hidden-secret"></form>', 'Login'));
    const authenticationCapture = await evaluate(captureExpression);
    assert.equal(authenticationCapture, 'null', 'authentication pages must not produce snapshots');

    await navigate(page('<h1>Timetable</h1><table><tr><th>Day</th><th>Room</th></tr><tr><td>Monday</td><td>Science Hall</td></tr></table>', 'Timetable'));
    await evaluate(injectAgain);
    const afterFullLoad = JSON.parse(await evaluate(captureExpression));
    assert.ok(afterFullLoad.nodes.some(node => node.kind === 'table' && node.rows[0][0] === 'Monday'),
      'reinstalling in a fresh full-page JavaScript context should capture its records');
  } finally {
    try { socket?.close(); } catch (_) {}
    if (browser.exitCode === null) {
      browser.kill('SIGTERM');
      await new Promise(resolve => browser.once('exit', resolve)).catch(() => {});
    }
    await rm(profile, {recursive: true, force: true});
  }
});
