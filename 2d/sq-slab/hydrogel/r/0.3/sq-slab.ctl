(define-param h 0.75) ; the thickness of the slab
(define-param eps 64) ; the dielectric constant of the slab
(define-param r 0.3) ; the radius of the holes




(set! geometry-lattice (make lattice (size 1 1 no-size))) ; 2d cell


(set! geometry
      (list(make block (material (make dielectric (epsilon eps)))
                  (center 0) (size 100 100 h))
                    (make cylinder (material air)
                  (center 0) (radius r) (height h))))

(set! num-bands 8)



(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0.5 0 kz)        ; X
                     (vector3 0.5 0.5 kz)      ; M
                     (vector3 0 0 kz)))        ; Gamma
(set! k-points (interpolate 4 k-points))
(set! resolution 32)
(if (= kz 0)
    (begin
      (run-te)
      (run-tm))
    (run)) ; if kz != 0 there are no purely te and tm bands

