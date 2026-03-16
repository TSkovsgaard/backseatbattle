# AGENTS.md

## Public content hygiene (mandatory)

This repository is public. Do not publish internal operations notes in user-facing content.

### Never include in public files

- Internal setup instructions (for example: repository settings click-paths).
- Maintainer-only TODO/FIXME notes in `README.md` or website pages.
- Credentials, tokens, secrets, private keys, or passwords.

### Before every push

Run:

```bash
./scripts/public-content-check.sh
```

If the script reports findings, remove or reword them before pushing.
