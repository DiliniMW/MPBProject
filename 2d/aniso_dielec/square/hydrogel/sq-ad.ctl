(define-param h 0.75) ; the thickness of the slab
(define-param eps 64) ; the dielectric constant of the slab
(define-param r 0.5) ; the radius of the holes

(set! num-bands 8)

(set! geometry-lattice (make lattice (size 1 1 no-size))) ; 2d cell

(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0.5 0 kz)        ; M
                     (vector3 0.5 0.5 kz)      ; K
                     (vector3 0 0 kz)))	       ; Gamma

(set! k-points (interpolate 4 k-points))

(set! resolution 32)

(set! geometry (list (make block (material (make dielectric (epsilon eps)))
                  (center 0) (size 100 100 h))
                    (make cylinder (material air)
                  (center 0) (radius r) (height h)
                       (material (make dielectric-anisotropic
                                   (epsilon-diag 1 1 eps))))))
(set! default-material (make dielectric-anisotropic (epsilon-diag eps eps 1)))
(set! num-bands 8)
(run)
