; A polymer photonic slab with holes in a triangular pattern.  (The polymer 
; is a Poly(4-vinylpyridine)-iodine complex which has a n of 2.08 giving
; an epsilon of 4.3246)

(define-param h 0.01) ; the thickness of the slab
(define-param eps 64) ; the dielectric constant of the slab
(define-param r 0.3) ; the radius of the holes

(set! geometry-lattice (make lattice (size 1 1 no-size)
                         (basis1 (/ (sqrt 3) 2) 0.5)
                         (basis2 (/ (sqrt 3) 2) -0.5)))
                         
(set! geometry
      (list(make block (material (make dielectric (epsilon eps)))
		  (center 0) (size 10 10 h))
		    (make cylinder (material air)
		  (center 0) (radius r) (height h))))
(set! num-bands 8)
(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0 0.5 kz)        ; M
                     (vector3 (/ -3) (/ 3) kz) ; K
                     (vector3 0 0 kz)))        ; Gamma
(set! k-points (interpolate 4 k-points))
(set! resolution 32)
(if (= kz 0)
    (begin
      (run-te(output-at-kpoint (vector3 (/ -3) (/ 3) 0)
                          fix-efield-phase output-efield-x) )
(run-tm (output-at-kpoint (vector3 (/ -3) (/ 3) 0)
                          fix-efield-phase output-efield-z))

      )
    (run)) ; if kz != 0 there are no purely te and tm bands

