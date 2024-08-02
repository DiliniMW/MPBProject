

(define-param h 0.75) ; the thickness of the slab
(define-param eps 64) ; the dielectric constant of the slab


(set! geometry-lattice (make lattice (size 1 1 no-size) ; 2d cell
   (basis1 (/ (sqrt 3) 2) 0.5)
                        (basis2 (/ (sqrt 3) 2) -0.5)))

(define (first-te-gap r)
(set! geometry
       (list(make block (material (make dielectric (epsilon eps)))
                  (center 0) (size 100 100 h))
                    (make cylinder
              (center (/ 6) (/ 6) 0) (radius r) (height h)
              (material (make dielectric (material air))))
            (make cylinder
              (center (/ -6) (/ -6) 0) (radius r) (height h)
                 (material (make dielectric (material air))))))

(run-te)
  (retrieve-gap 5)) ; return the gap from TE band 5 to TE band 6

(set! num-bands 6)
(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0 0.5 kz)        ; X
                     (vector3 (/ -3) (/ 3) kz)      ; M
                     (vector3 0 0 kz)))        ; Gamma

(set! k-points (interpolate 4 k-points))
(set! resolution 32)
(set! mesh-size 7) ; increase from default value of 3

(define result (maximize first-te-gap 0.1 0.1 1))
(print "radius at maximum: " (max-arg result) "\n")
(print "gap size at maximum: " (max-val result) "\n")

(set! mesh-size 3) ; reset to default value of 3

