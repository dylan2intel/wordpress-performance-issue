# wordpress-performance-issue

Wordpress6MT performance drop RCA (root cause addressing) update.

After experiment on ` git cherry -v 5.9-branch 6.0-branch |cat -n > ~/commits_on_6.0_branch.txt`  totally 707 commits. Addressed that the performance drop issue is due to this commit ![ab8a964858e7eba50c2caed21cc9415282f89d14](https://github.com/WordPress/WordPress/commit/ab8a964858e7eba50c2caed21cc9415282f89d14)

| NO  | Commit ID                                | Commit Message                                                                                                                | Transaction/sec |
|-----|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------|
| 1   | 5fc6f2a4889ed61149dfcb7adfd5312bb7edd8c1 | Trunk   is now 6.0-alpha. Built from https://develop.svn.wordpress.org/trunk@52448                                            | 217.25          |
| 354 | 7b96116f3fb6938a33f157d53e69cdcdec242694 | Twenty   Twenty: Fix aria-expanded handling in search toggle.                                                                 | 209.71          |
| 443 | 476e73194d2e98e477f691e44b9a8e7284c9c175 | Users:   Improve wording of the "New Admin Email Address" email.                                                              | 212.07          |
| 454 | bc0f1865991b856b35b996759837062b84ecb08e | Administration:   Clarify some sentences after [53131].                                                                       | 207.59          |
| 455 | ab8a964858e7eba50c2caed21cc9415282f89d14 | Editor:   Update WordPress packages based based on Gutenberg v13.0 RC3                                                        | 186.43          |
| 456 | bb723f99206bd1256a10134cd9a74984c33103b4 | Widgets:   Avoid 27 duplicate translations in Media Widgets constructor.                                                      | 182.69          |
| 457 | 4dd4aec2d1b8c17027d38ddca7c6cfd3a961c561 | Administration:   Add unit test for term supplementary notice.                                                                | 185.76          |
| 459 | 1d29cb663289795c6aca5cf8c624db6ac2475b49 | Media:   Enable edits to custom image sizes.                                                                                  | 184.88          |
| 465 | e1a2ae351a82521d12ef873f614adb42825c6de4 | Post   WordPress 6.0 Beta 1 version bump. Built from   https://develop.svn.wordpress.org/trunk@53167                          | 184.04          |
| 487 | 407e802048a7cf8c1dab6575fc9b828572e24af2 | Docs:   Use third-person singular verbs for function descriptions in   `author-template.php`, as per documentation standards. | 188.67          |
| 531 | 943e956379dd935ad6b401669a4c76526172f594 | Feeds:   Use latest comment date for the `Last-Modified` header of comments feed.                                             | 182.66          |
| 707 | a9c0050f9475857e80e813d8841052e0dde36efc | Post   WordPress 6.0.2 version bump.                                                                                          | 181.87          |
