; A polymer photonic slab with holes in a triangular pattern.  (The polymer 
; is a Poly(4-vinylpyridine)-iodine complex which has a n of 2.08 giving
; an epsilon of 4.3246)

(define-param h 0.75) ; the thickness of the slab
(define-param eps 4.3246) ; the dielectric constant of the slab


(set! geometry-lattice (make lattice (size 1 1 no-size))) ; 2d cell

(define (first-te-gap r)
(set! geometry
      (list(make block (material (make dielectric (epsilon eps)))
		  (center 0) (size 100 100 h))
		    (make cylinder (material air)
		  (center 0) (radius r) (height h))))
(run-te)
  (retrieve-gap 4)) ; return the gap from TE band 4 to TE band 5

(set! num-bands 5)
(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0.5 0 kz)        ; X
                     (vector3 0.5 0.5 kz)      ; M
                     (vector3 0 0 kz)))        ; Gamma

(set! k-points (interpolate 4 k-points))
(set! resolution 32)
(set! mesh-size 7) ; increase from default value of 3

(define result (maximize first-te-gap 0.1 0.1 1))
(print "radius at maximum: " (max-arg result) "\n")
(print "gap size at maximum: " (max-val result) "\n")

(set! mesh-size 3) ; reset to default value of 3

