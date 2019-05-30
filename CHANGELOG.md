# 0.3.0

- [ ] SDL output in progress.
- [ ] Improve SDL performance
- [ ] https://stackoverflow.com/questions/20753726/rendering-pixels-from-array-of-rgb-values-in-sdl-1-2/36504803#36504803

# 0.2.0

Terminal class now only works in the terminal and the new Spinner class should be used in the rake tasks. That should actually be a major version update to be honest but in 0.x versions I assume it's expected things can break.

- [x] Split Terminal class into `Base`, `Terminal` and `Spinner` classes
- [x] Started work on SDL version
- [x] Updated readme and example
- [x] Update tests

# 0.1.0

Works both in terminal as a command and in long running rake tasks as a spinner/progress bar indicator (not really).

- [x] Initial gem version published