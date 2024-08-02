; A polymer photonic slab with holes in a triangular pattern.  (The polymer 
; is hydrogel mixed with Acrylamide giving it a n of 8 so epsilon is 64)

(define-param h 0.75) ; the thickness of the slab
(define-param eps 64) ; the dielectric constant of the slab


(set! geometry-lattice (make lattice (size 1 1 no-size))) ; 2d cell

(define (first-tm-gap r)
(set! geometry
      (list(make block (material (make dielectric (epsilon eps)))
		  (center 0) (size 100 100 h))
		    (make cylinder (material air)
		  (center 0) (radius r) (height h))))
(run-tm)
  (retrieve-gap 1)) ; return the gap from TM band 1 to TM band 2

(set! num-bands 2)
(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0.5 0 kz)        ; X
                     (vector3 0.5 0.5 kz)      ; M
                     (vector3 0 0 kz)))        ; Gamma

(set! k-points (interpolate 4 k-points))
(set! resolution 32)
(set! mesh-size 7) ; increase from default value of 3

(define result (maximize first-tm-gap 0.1 0.1 2.0))
(print "radius at maximum: " (max-arg result) "\n")
(print "gap size at maximum: " (max-val result) "\n")

(set! mesh-size 3) ; reset to default value of 3

