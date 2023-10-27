# gami_acad

A new Flutter project.

## Development:
- LeftHook
  - Before committing any changes, LeftHook must be installed and activated
  - Use `npm install -g lefthook --save-dev` to install
  - Then execute `lefthook install` to activate it using the `lefthook.yml` configurations

- Git Ignore .env file
  - In order to ignore changes made to the .env file, simply run `git update-index --assume-unchanged ./.env`

- Testing
  - Before testing your code, run the command `dart run build_runner build` in order to generate the mock files
  - Then simply run `flutter test`