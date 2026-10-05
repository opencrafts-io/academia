import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/data/repositories/shared_preferences_portal_cache_store.dart';
import 'package:portal_sync/src/data/repositories/shared_preferences_portal_usage_store.dart';
import 'package:portal_sync/src/domain/entities/portal_analysis_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'cache scopes validated plans by account, origin, language and structure',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final cache = SharedPreferencesPortalCacheStore(prefs);
      final plan = PortalAnalysisPlan.fromJson({
        'pageType': 'other',
        'tables': [],
      });
      await cache.putPlan(
        accountId: 'a',
        origin: 'https://one.edu',
        language: 'en',
        fingerprint: 'f',
        modelVersion: 'model-a',
        plan: plan,
      );

      expect(
        await cache.getPlan(
          accountId: 'a',
          origin: 'https://one.edu',
          language: 'en',
          fingerprint: 'f',
          modelVersion: 'model-a',
        ),
        isNotNull,
      );
      expect(
        await cache.getPlan(
          accountId: 'a',
          origin: 'https://one.edu',
          language: 'en',
          fingerprint: 'f',
          modelVersion: 'model-b',
        ),
        isNull,
      );
      expect(
        await cache.getPlan(
          accountId: 'b',
          origin: 'https://one.edu',
          language: 'en',
          fingerprint: 'f',
          modelVersion: 'model-a',
        ),
        isNull,
      );
      expect(
        await cache.getPlan(
          accountId: 'a',
          origin: 'https://two.edu',
          language: 'en',
          fingerprint: 'f',
          modelVersion: 'model-a',
        ),
        isNull,
      );
      expect(
        await cache.getPlan(
          accountId: 'a',
          origin: 'https://one.edu',
          language: 'fr',
          fingerprint: 'f',
          modelVersion: 'model-a',
        ),
        isNull,
      );
      await cache.clearAccount('a');
      expect(
        await cache.getPlan(
          accountId: 'a',
          origin: 'https://one.edu',
          language: 'en',
          fingerprint: 'f',
          modelVersion: 'model-a',
        ),
        isNull,
      );
    },
  );

  test(
    'usage limits persist across store instances and account reconnects',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.utc(2026, 10, 4, 10);
      final first = SharedPreferencesPortalUsageStore(
        prefs,
        dailyLimit: 2,
        monthlyLimit: 3,
        initialSetupLimit: 1,
      );
      expect(await first.canAttempt('account', now: now), isTrue);
      await first.recordAttempt('account', now: now);
      expect(await first.canAttempt('account', now: now), isFalse);
      await first.markSetupComplete('account');
      final reconnected = SharedPreferencesPortalUsageStore(
        prefs,
        dailyLimit: 2,
        monthlyLimit: 3,
        initialSetupLimit: 1,
      );
      expect(await reconnected.canAttempt('account', now: now), isTrue);
      await reconnected.recordAttempt('account', now: now);
      expect(await reconnected.canAttempt('account', now: now), isFalse);
      expect(await reconnected.canAttempt('other', now: now), isTrue);
    },
  );
}
