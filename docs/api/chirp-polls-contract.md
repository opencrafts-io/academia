# Chirp Polls — API contract

Status: **proposed** (client implemented against this; backend pending).

All paths are prefixed with the chirp service prefix used by the app
(`chirp` / `qa-chirp` / `dev-chirp`, see `ChirpRemoteDataSource.servicePrefix`).
Authentication is the same as other chirp endpoints.

Until the backend ships, the app wires `MockPollRemoteDataSource`
(`lib/features/chirp/posts/data/datasources/poll_mock_data_source.dart`) in
`injection_container.dart`. Swap it for `ChirpPollRemoteDataSource` there.

## Poll object

Embedded in every post payload as `poll` (`null` when the post has no poll).

```json
{
  "id": 41,
  "post": 1203,
  "question": "Which exam should we revise first?",
  "allows_multiple": false,
  "is_anonymous": false,
  "ends_at": "2026-09-14T18:00:00Z",
  "total_votes": 27,
  "my_votes": [88],
  "options": [
    { "id": 87, "text": "Calculus", "position": 0, "vote_count": 12 },
    { "id": 88, "text": "Databases", "position": 1, "vote_count": 15 }
  ]
}
```

| Field | Notes |
|---|---|
| `total_votes` | Number of **distinct voters**, not the sum of `vote_count`. In a multi-select poll a voter appears in several options but counts once here. Percentages are computed as `vote_count / total_votes`. |
| `my_votes` | Option ids the *requesting* user has selected. Empty array when they have not voted. |
| `ends_at` | Nullable ISO-8601 UTC. When in the past the poll is closed: votes are rejected with `400`. |
| `options[].position` | Zero-based display order. Client sorts by it. |

## Create a post with a poll

`POST /{prefix}/posts/create/` — existing endpoint, existing body, plus an
optional `poll` object:

```json
{
  "title": "...",
  "author_id": "...",
  "community_id": 7,
  "content": "...",
  "poll": {
    "question": "Which exam should we revise first?",
    "allows_multiple": false,
    "is_anonymous": false,
    "ends_at": "2026-09-14T18:00:00Z",
    "options": [
      { "text": "Calculus", "position": 0 },
      { "text": "Databases", "position": 1 }
    ]
  }
}
```

Validation the server must enforce (the client enforces the same rules in
`PollValidator`):

- `question`: 3–200 chars after trimming
- `options`: 2–10 entries, each 1–100 chars after trimming, case-insensitively unique
- `ends_at`: if present, at least 5 minutes in the future

Response: `201` with the full post JSON including the created `poll`.

## Vote

`POST /{prefix}/polls/{poll_id}/vote/`

```json
{ "voter_id": "user-uuid", "option_ids": [88] }
```

Semantics: **replaces** the caller's entire selection for this poll.

- Single-select polls: `option_ids` must contain exactly one id.
- Multi-select polls: 1..n ids.
- Sending an empty array is invalid — use `DELETE` to retract.
- Ids not belonging to the poll → `400`.
- Closed poll → `400`.

Response: `200` with the updated poll object (server-authoritative counts and
`my_votes`). The client reconciles its optimistic state against this.

## Retract vote

`DELETE /{prefix}/polls/{poll_id}/vote/`

```json
{ "voter_id": "user-uuid" }
```

Removes all of the caller's selections. Idempotent — returns `200` with the
poll object even if the user had not voted. Returns `400` once the poll has
closed (final results stay final).

## List voters

`GET /{prefix}/polls/{poll_id}/voters/?option_id=88&page=1&page_size=20`

`option_id` is optional; omit it to list every voter.

```json
{
  "count": 15,
  "next": "…?page=2",
  "previous": null,
  "results": [
    { "user_id": "user-uuid", "option_ids": [88], "voted_at": "2026-09-11T09:12:44Z" }
  ]
}
```

Authorization: when `is_anonymous` is `true`, only the post author may call
this; everyone else receives `403`. The client hides the "View votes" action
for non-authors on anonymous polls and shows a lock note for the author.

## Access rules (all poll endpoints)

`403` when the caller is not a member of the post's private community, is a
banned member of that community, or has a mutual block with the post author.
Public-community polls are open to any authenticated user.
