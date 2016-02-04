## Making a new Ceylon release on the website

For both a major and minor release, we work on a branch until we merge it on master.

### Major release

- Copy `/documentation/y.x` to `/documentation/y.(x+1)`.
- Update `.htaccess` to point to the new current documentation:
```
RewriteRule ^documentation/current(.*)$ /documentation/1.2$1 [L]
```
- Plus all the changes for a minor release.

### Minor release

- Announcement blog post
-- Involves updating the contributor list
- Point to announcement from front page `index.html.haml` and both download pages
- Update `download.md` page to point to new release
- Update `download-archive.html.haml` to add the new release
- Update `.htaccess` to add download links:
```
RewriteRule ^download/dist/1_2_0$ "https\:\/\/downloads\.ceylon-lang\.org\/cli\/ceylon-1\.2\.0\.zip" [R=302,L]
RewriteRule ^download/dist/1_2_0_deb$ "https\:\/\/downloads\.ceylon-lang\.org\/cli\/ceylon-1\.2\.0_1\.2\.0_all\.deb" [R=302,L]
RewriteRule ^download/dist/1_2_0_rpm$ "https\:\/\/downloads\.ceylon-lang\.org\/cli\/ceylon-1\.2\.0-1\.2\.0-0\.noarch\.rpm" [R=302,L]
```
