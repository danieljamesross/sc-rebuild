# sc-rebuild

## Updating SBCL & slippery chicken
[SBCL](https://sbcl.org/) is regularly updated, which is great.

Installing and updating via [homebrew](https://brew.sh) makes this really convenient.

Deleting all your `.fasl` installation files and rebuilding _slippery chicken_ with the latest SBCL, however, is time consuming and inelegant.

I'm a lazy programmer, so I wrote the following script to save me precious seconds.

### Remove .fasl files
The following code uses the wonderful [UIOP](https://common-lisp.net/project/asdf/uiop.html) library (which comes installed as part of recent SBCL releases by default). It looks inside all of the "bin" directories that you supply (for sc with optional CMN & CLM) and deletes any `.fasl` files. When you relaunch you lisp with `M-x slime`, _slippery chicken_ gets re-compiled with the latest version of SBCL. 

#### Example
```lisp
(rm-fasl-files "~/sc/bin"
	       :cmn-bin "~/lisp/cmn"
	       :clm-bin "~/lisp/clm-5"
	       :simulate nil)
```
The above code on my mac returns:

```lisp
Deleted 77 files in /Users/danieljross/sc/bin
Deleted 21 files in /Users/danieljross/lisp/cmn
Deleted 15 files in /Users/danieljross/lisp/clm-5
=>
("/Users/danieljross/sc/bin" "/Users/danieljross/lisp/cmn"
 "/Users/danieljross/lisp/clm-5")
```

Set `:simulate` to `t` if you want to run this code without actually deleting anything.

### Installation
Download `sc-rebuild.lsp` and load it.

Any problems, raise an issue.

##### Happy lisping!
