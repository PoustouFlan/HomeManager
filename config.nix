{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    myEmacsConfig = writeText "default.el" ''
      ;; initialize package
    (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
      (when no-ssl (warn "No ssl found"))
     (add-to-list 'package-archives (cons "melpa"
      (concat proto "://melpa.org/packages/")) t)
     )
    (add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
      (require 'package)
      (package-initialize 'noactivate)
      (eval-when-compile
        (require 'use-package))

      ;; load some packages

      (use-package tuareg
       )
    '';

    myEmacs = emacs.pkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
      (runCommand "default.el" {} ''
        mkdir -p $out/share/emacs/site-lisp
        cp ${myEmacsConfig} $out/share/emacs/site-lisp/default.el
      '')
            tuareg
            use-package
    ]));
  };
}
