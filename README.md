Deploy GHCJS applications to GitHub pages
=========================================

This repository demonstrates how to very simply deploy GHCJS-based applications to
GitHubPages, using Travis CI.

HOWTO
-----

1. Clone this repository, or drop its `.travis.yml` file into an existing
   repository.
2. Create a “Personal access tokens” on <https://github.com/settings/tokens>.
   Make sure it has the “repo“ permission.
3. Go to the settings page of your repository on Travis
   (e.g. <https://travis-ci.org/nomeata/ghcjs2gh-pages/settings>). Enable
   Travis, if not done yet. Under “Environment Variables”, store the personal
   access token from above, with name `GITHUB_TOKEN`.
4. Wait.

If everything works, you will be using your GHCJS program on the Github Page
URL for this project, e.g. <http://nomeata.github.io/ghcjs2gh-pages>.


FAQ
---

  * Why are you not using Stack or Nix?

    This setup uses plain Cabal (no stack, no nix), not because Stack or Nix
    are bad tool, but to make this accessible to as many developers as
    possible. But ideally, it should not matter what happens on Travis.

  * I have too many dependencies, and the build times out.

    If you trigger a build via the Travis web UI (top-right corner, “More
    Options” – “Trigger Build”), then travis will run an additional
    cache-warming stage where it will only build dependencies. This might
    help with the build. Let us know if this is still too slow, we have ideas.

  * Is the example program in this repository a good example of idiomatic
    `ghcjs-dom` use?

    No, surely not. I crudely forward-ported this demo that I wrote in 2015. If
    anyone wants to rewrite the `Main.hs` in this repository to follow best
    practices, that’d be amazing!

  * Can I use my own domain name?

    Yes. See
    <https://help.github.com/articles/using-a-custom-domain-with-github-pages/>
    and set the domain name in the `fqdn` field in `.travis.yaml`.

  * Anyways, what’s the deal?

    GHCJS is tricky to build, but thanks to [hvr’s GHCJS
    PPA](https://launchpad.net/~hvr/+archive/ubuntu/ghcjs) the pain is lessend.

  * Why `--constraint="primitive < 0.6.4.0`?

    Becuase of this bug: https://github.com/ghcjs/ghcjs/issues/665

Possible improvements (patches welcome!)
----------------------------------------

 * Document here how to do local development without GHCJS.

 * Find out and document how to handle data files that need to be available to
   the program, and/or data files that need to be available to the browser, in
   a way that works both locally (with GHC) and remotely (with GHCJS).

 * Clean up `Main.hs` (see question above).

 * Also build the program using regular GHC on travis, to see if that works.

 * Build the test suite, if present, and only deploy if it passes.

Contact
-------

Please reports bugs and missing features at the [GitHub bugtracker]. This is
also where you can find the [source code].

`ghcjs2gh-pages` was written by [Joachim Breitner] and is licensed under a
permissive MIT [license].

[GitHub bugtracker]: https://github.com/nomeata/ghcjs2gh-pages/issues
[source code]: https://github.com/nomeata/ghcjs2gh-pages
[Joachim Breitner]: http://www.joachim-breitner.de/
[license]: https://github.com/nomeata/ghcjs2gh-pages/blob/LICENSE


