(define-param h 0.01) ; the thickness of the slab
(define-param eps 4.3246) ; the dielectric constant of the slab
(define-param r 0.39) ; the radius of the holes

(set! num-bands 8)

(set! geometry-lattice (make lattice (size 1 1 no-size)
                         (basis1 (/ (sqrt 3) 2) 0.5)
                         (basis2 (/ (sqrt 3) 2) -0.5)))
(define-param kz 0) ; use non-zero kz to consider vertical propagation
(set! k-points (list (vector3 0 0 kz)          ; Gamma
                     (vector3 0 0.5 kz)        ; M
                     (vector3 (/ -3) (/ 3) kz) ; K
                     (vector3 0 0 kz)))	       ; Gamma

(set! k-points (interpolate 4 k-points))

(set! resolution 32)

(set! geometry (list (make block (material (make dielectric (epsilon eps)))
                  (center 0) (size 10 10 h))
                    (make cylinder (material air)
                  (center 0) (radius r) (height h)
                       (material (make dielectric-anisotropic
                                   (epsilon-diag 1 1 eps))))))
(set! default-material (make dielectric-anisotropic (epsilon-diag eps eps 1)))
(set! num-bands 8)
(run)
