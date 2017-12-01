#lang racket

(require "genetic_algorithm.rkt")


; a chromosome is a list of numbers in [0, 10], the fitness function is - sum
(define (create-env) 
(let ((po-size 30) ; crossover assume this to be even
      (chro-length 10)
      (crossover-probability 0.2)
      (crossover-mid 5)
      (mutation-probability 0.1)) 

  (define (ini-po)
    (define (ini size po)
      (if (= 0 size)
          po
          (ini (sub1 size) (cons (build-list chro-length (lambda (x) (random 10))) po))))
    (ini po-size '()))

  (define (crossover couple)
    (let ((x (car couple))
          (y (car (cdr couple))))
      (if (< (random) crossover-probability)
          (cons x (cons y '()))
          (cons
           (append (take x crossover-mid) (drop y crossover-mid))
           (cons (append (drop x crossover-mid) (take y crossover-mid)) '())))))

  (define (mutation chro)
    (define (mu chro pos index)
      (let ((x (car chro))
            (xs (cdr chro)))
        (if (null? xs)
            chro
            (if (= index pos)
                (cons (random 10) xs)
                (cons x (mu xs pos (add1 index)))))))
    (if (< (random) mutation-probability)
        (mu chro (random chro-length) 0)
        chro))

  (define (select-elem po fs)
    (let* ((sum (foldl + 0 fs)) ; note that this assume the ff to be always positive
           (ps (map (lambda (x) (/ x sum)) fs)))
      ; given a random n in [0, 1] iterate over the elements of the list
      ; until the cumulated probability is greater or equal to n
      (define (get-rnd po ps acc n)
        (if (> acc n) ; acc need to start from the probability value of the first element, not 0
            (car po)
            (get-rnd (cdr po) (cdr ps) (+ acc (car ps)) n)))
      ; return a pair
      (cons (get-rnd po (cdr ps) (car ps) (random)) (cons (get-rnd po (cdr ps) (car ps) (random)) '()))))

  (genetic-env
   (lambda (chro) ( - 100 (foldl + 0 chro))) ; fitness function
   (lambda (pf cf s) (= 50000 s)) ; stop condition
   (lambda (x y) (> x y)) ; better
   ini-po
   crossover
   mutation
   select-elem
   po-size)
  )
)

(let ((e (create-env)))
  (genetic e))