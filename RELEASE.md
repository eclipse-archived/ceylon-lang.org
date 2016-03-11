## Making a new Ceylon release on the website

For both a major and minor release, we work on a branch until we merge it on master.

### Major release

- Copy `/documentation/y.x` to `/documentation/y.(x+1)`.
- Update `.htaccess` to point to the new current documentation:

```
RewriteRule ^documentation/current(.*)$ /documentation/1.2$1 [L]
```

- Update the documentation URLs in `_config/urls.yml` 
- Update the priorities in `_config/sitemap.yml`, so the new release docs 
  get higher priority (and the old release docs revert back to default priority)
- Plus all the changes for a minor release.

### Minor release

- Announcement blog post

    - Involves updating the contributor list
    
- Point to announcement from front page `index.html.haml` and both download pages
- Update `download.md` page to point to new release
- Update `download-archive.html.haml` to add the new release
- Update `.htaccess` to add download links:

```
RewriteRule ^download/dist/1_2_0$ "https\:\/\/downloads\.ceylon-lang\.org\/cli\/ceylon-1\.2\.0\.zip" [R=302,L]
RewriteRule ^download/dist/1_2_0_deb$ "https\:\/\/downloads\.ceylon-lang\.org\/cli\/ceylon-1\.2\.0_1\.2\.0_all\.deb" [R=302,L]
RewriteRule ^download/dist/1_2_0_rpm$ "https\:\/\/downloads\.ceylon-lang\.org\/cli\/ceylon-1\.2\.0-1\.2\.0-0\.noarch\.rpm" [R=302,L]
```

- Update the `apidoc_current_*` Herd URLs in `_config/urls.yml` 
- Run `ceylon ant-task-doc` in `documentation/*release*/reference/tools/` 
  to generate documentation of the `ant` task
- Merge the branch into `master`, delete the old branch

## On the server itself

Log on `ceylonlang.org`:

WARNING: try those on for size before you run them, especially the `sudo` ones, as you should
never copy and paste `sudo` commands!!! So read them carefully and type them by hand.

1. Get the release
  -  $ unzip /var/www/downloads.ceylonlang/cli/ceylon-1.2.1.zip
2. Remove the old API and spec (if not publishing a new minor release, eg. 1.2 -> 1.3)
  -  $ sudo rm -rf /var/www/ceylonlang/documentation/1.2/spec/{html,html_single,pdf,shared}
4. Make sure you tell the website hooks to not remove your precious files:
  -  $ sudo vim /var/www/ceylonlang/hooks/rsync-excludes
5. Put the updated (or new) spec
  -  $ sudo cp -r ceylon-1.2.1/doc/en/spec/{html,html_single,shared,pdf} /var/www/ceylonlang/documentation/1.2/spec/
  -  $ sudo chown -R webhook. /var/www/ceylonlang/documentation/1.2/spec
  -  $ sudo mv /var/www/ceylonlang/documentation/1.2/spec/pdf/Ceylon* /var/www/ceylonlang/documentation/1.2/spec/pdf/ceylon-language-specification.pdf
6. Put the new tooldocs
  -  $ sudo rm -rf /var/www/ceylonlang/documentation/1.2/reference/tool/ceylon/subcommands
  -  $ sudo cp -r ceylon-1.2.1/doc/en/toolset /var/www/ceylonlang/documentation/1.2/reference/tool/ceylon/subcommands
  -  $ sudo chown -R webhook. /var/www/ceylonlang/documentation/1.2/reference/tool/ceylon/subcommands
