# `mozconfig` Switcher

A simple TUI utility to switch between different
[`mozconfig`](https://firefox-source-docs.mozilla.org/build/buildsystem/mozconfigs.html)s
in the Mozilla source code.

## Installation

```sh
gem install mozconfig
```

## Usage

Your `mozconfig` should be formatted like this, for example:

```py
mk_add_options AUTOCLOBBER=1

# Firefox
ac_add_options --with-branding=browser/branding/nightly
ac_add_options --with-ccache=sccache

# Firefox (artifact build)
# mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-artifact-@CONFIG_GUESS@
# ac_add_options MOZ_TELEMETRY_REPORTING=1
# ac_add_options --with-branding=browser/branding/nightly
# ac_add_options --enable-artifact-builds

# Firefox for Android
# mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-android-@CONFIG_GUESS@
# ac_add_options --enable-project=mobile/android

# SpiderMonkey (debug)
# mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-js-debug-@CONFIG_GUESS@
# ac_add_options --enable-project=js
# ac_add_options --with-ccache=sccache
# ac_add_options --enable-debug
# ac_add_options --disable-optimize

# SpiderMonkey (optimized)
# mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-js-opt-@CONFIG_GUESS@
# ac_add_options --enable-project=js
# ac_add_options --with-ccache=sccache
# ac_add_options --enable-optimize
# ac_add_options --disable-debug

# Thunderbird
# mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-mail-@CONFIG_GUESS@
# ac_add_options --with-branding=comm/mail/branding/nightly
# ac_add_options --enable-project=comm/mail
# ac_add_options --with-ccache=sccache

# Thunderbird (artifact build)
# mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-mail-@CONFIG_GUESS@
# ac_add_options --with-branding=comm/mail/branding/nightly
# ac_add_options --enable-project=comm/mail
# ac_add_options --enable-artifact-builds
```

The options are separated into "paragraphs", each one a separate configuration.
This tool will comment out all of the inactive configurations. The comment
above each paragraph will be the name displayed in the TUI. Any paragraph
without a comment above it will remain active in all configurations.

Run `mozconfig` at the root of the source tree and you will be presented with a
picker where you can select your configuration, e.g.:

![Screenshot of
TUI](https://github.com/vinnydiehl/mozconfig/blob/main/.github/images/screenshot.png)

Your current configuration will already be highlighted. You can use the up/down
arrows (or `k` and `j` if you're a vim fan) to change the selection, then hit
Enter to switch your configuration, or Escape to exit without changing anything.
