# lisp-scrips
Scripts in Common Lisp

## Clean-files.lisp

If you need delete securely all files of a directory use this script, the main application is [shred](https://www.man7.org/linux/man-pages/man1/shred.1.html)

### Usage

```lisp
(secure-delete "/home/user/file.txt")
(secure-delete "/home/user/directory/")
```

## list-big-files.lisp

List the files of a directory as "ls" of GNU, but ordered the files by sizes.

### Usage

```lisp
(list-big-files "/home/user/file.txt")
(list-big-files "/home/user/directory")
```
