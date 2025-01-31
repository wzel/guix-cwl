;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2018 Pjotr Prins <pjotr.guix@thebird.nl>
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (cwl cwl)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages node)
  #:use-module (gnu packages rdf)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages time)
  #:use-module (gnu packages version-control)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (cwl python)
  ; #:use-module (guix build-system gnu)
  #:use-module (guix build-system python)
  ; #:use-module (guix build-system trivial)
  #:use-module (srfi srfi-1))

(define-public cwltool ; guix: needs work
  (let ((commit "15539fba76993f951af9eba913bea6d677c74005"))
  (package
    (name "cwltool")
    (version "1.0.20181012180214")
    (source
      (origin
        ; (method url-fetch)
        ; (uri (string-append
        ;        "https://pypi.python.org/packages/source/c/cwltool/cwltool-"
        ;        version
        ;       ".tar.gz"))
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/genenetwork/cwltool.git")
               (commit commit)))
         (file-name (git-file-name name version))
        (sha256
          (base32
            "1qwfa82car7477sy0cb5bj4964w7zq7dcw2bdcls6c2i9qdp0586"))))
    (build-system python-build-system)
    ; (inputs
    ;  `(("python@3.6.5" ,python-3.6.5)))
    (propagated-inputs ; a lot of these are used for testing
     `(("git" ,git)
       ("node" ,node)
       ("python-bagit" ,python-bagit)
       ("python-cachecontrol-0.11.7" ,python-cachecontrol-0.11.7) ; requires 0.12
       ("python-arcp" ,python-arcp)
       ("python-setuptools-vtags" ,python-setuptools-vtags)
       ("python-dateutil" ,python-dateutil)
       ("python-pytest-cov" ,python-pytest-cov)
       ("python-prov" ,python-prov)
       ("python-pytest-runner" ,python-pytest-runner)
       ("python-rdflib" ,python-rdflib)
       ("python-pyparsing" ,python-pyparsing)
       ("python-pytest-mock" ,python-pytest-mock)
       ("python-mock" ,python-mock)
       ("python-subprocess32" ,python-subprocess32)
       ("python-ruamel.yaml" ,python-ruamel.yaml)
       ("python-cachecontrol-0.11.7" ,python-cachecontrol-0.11.7)
       ("python-lxml" ,python-lxml)
       ("python-mypy-extensions" ,python-mypy-extensions)
       ("python-mistune" ,python-mistune)
       ("python-networkx" ,python-networkx)
       ("python-schema-salad" ,python-schema-salad)
       ("python-html5lib" ,python-html5lib)
       ("python-rdflib-jsonld" ,python-rdflib-jsonld)
       ; ("python-typing-extensions" ,python-typing-extensions)
       ("python-scandir" ,python-scandir)
       ("python-psutil" ,python-psutil)
       ))
    (arguments
     `(;#:phases
       ; (modify-phases %standard-phases
       ;   (replace 'check
       ;     (lambda* (#:key inputs outputs #:allow-other-keys)
       ;       (invoke "python" "-m" "pytest")
       ;       )))
       #:tests? #f))   ; Disable for now because 3 out of 100+ tests are failing
    (home-page
      "https://github.com/common-workflow-language/common-workflow-language")
    (synopsis
      "Common workflow language reference implementation")
    (description
      "Common workflow language reference implementation")
    (license license:asl2.0))))

(define-public python-schema-salad
  (let ((commit "eb85c3d49b99b7643e8a12248e2dc05504910c1e"))
  (package
    (name "python-schema-salad")
    (version "3.0.20181206233650")
    (source
      (origin
        ; (method url-fetch)
        ; (uri (pypi-uri "schema-salad" version))
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/genenetwork/schema_salad.git")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "174f224zzjr0nbjlq3ypciyfijnibasysrgjswvx8yhan2dizlhr"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f)) ;; CWL includes no tests.
    (inputs
     `(("python-cachecontrol-0.11.7" ,python-cachecontrol-0.11.7) ; requires 0.12
       ("python-cython" ,python-cython)
       ("python-setuptools-vtags" ,python-setuptools-vtags)
       ("python-rdflib-jsonld" ,python-rdflib-jsonld)
       ("python-mistune" ,python-mistune)))
    (propagated-inputs
     `(("python-rdflib" ,python-rdflib)
       ("python-avro" ,python-avro)
       ("python-pyyaml" ,python-pyyaml)
       ("python-requests" ,python-requests)
       ("python-shellescape" ,python-shellescape)
       ))
    (home-page
      "https://github.com/common-workflow-language/common-workflow-language")
    (synopsis
      "Schema Annotations for Linked Avro Data (SALAD)")
    (description
      "Schema Annotations for Linked Avro Data (SALAD)")
    (license license:asl2.0))))
