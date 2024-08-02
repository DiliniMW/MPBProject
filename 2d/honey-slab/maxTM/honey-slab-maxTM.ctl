; A polymer photonic slab with holes in a triangular pattern.  (The polymer 
; is a Poly(4-vinylpyridine)-iodine complex which has a n of 2.08 giving
; an epsilon of 4.3246)

(define-param h 0.75) ; the thickness of the slab
(define-param eps 4.3246) ; the dielectric constant of the slab


(set! geometry-lattice (make lattice (size 1 1 no-size) ; 2d cell
   (basis1 (/ (sqrt 3) 2) 0.5)
                        (basis2 (/ (sqrt 3) 2) -0.5)))

(define (first-tm-gap r)
(set! geometry
       (list(make block (material (make dielectric (epsilon eps)))
                  (center 0) (size 100 100 h))
                    (make cylinder
              (center (/ 6) (/ 6) 0) (radius r) (height h)
              (material (make dielectric (material air))))
            (make cylinder
              (center (/ -6) (/ -6) 0) (radius r) (height h)
                 (material (make dielectric (material air))))))

(run-tm)
  (retrieve-gap 6)) ; return the gap from TM band 6 to TM band 7

(set! num-bands 7)
(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0 0.5 kz)        ; X
                     (vector3 (/ -3) (/ 3) kz)      ; M
                     (vector3 0 0 kz)))        ; Gamma

(set! k-points (interpolate 4 k-points))
(set! resolution 32)
(set! mesh-size 7) ; increase from default value of 3

(define result (maximize first-tm-gap 0.1 0.1 1))
(print "radius at maximum: " (max-arg result) "\n")
(print "gap size at maximum: " (max-val result) "\n")

(set! mesh-size 3) ; reset to default value of 3

