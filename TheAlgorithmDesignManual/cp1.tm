<TeXmacs|1.99.6>

<style|<tuple|generic|chinese>>

<\body>
  1-1. [3] Show that a + b can be less than min(a, b).\ 

  <\solution>
    \<#5F53\> a \<#548C\> b \<#90FD\>\<#4E3A\>\<#8D1F\>\<#6570\>\<#7684\>\<#65F6\>\<#5019\>\<#3002\>
  </solution>

  \;

  1-2. [3] Show that a \<times\> b can be less than min(a, b).

  <\solution>
    \<#5F53\> a \<#6216\>\<#8005\> b \<#5176\>\<#4E2D\>\<#4E00\>\<#4E2A\>\<#4E3A\>\<#8D1F\>\<#6570\>\<#540C\>\<#65F6\>\<#53E6\>\<#5916\>\<#4E00\>\<#4E2A\>\<#4E3A\>\<#6B63\>\<#6570\>\<#FF0C\>\<#53E6\>\<#5916\>\<#4E00\>\<#79CD\>\<#60C5\>\<#51B5\>\<#662F\>
    a \<#548C\> b \<#90FD\>\<#4E3A\>\<#5C0F\>\<#4E8E\>0\<#7684\>\<#5C0F\>\<#6570\>\<#65F6\>\<#3002\>
  </solution>

  \;

  1-5. [4] The knapsack problem is as follows: given a set of integers S =
  {s1, s2,...,sn}, and a target number T, find a subset of S which adds up
  exactly to T. For example, there exists a subset within S = {1, 2, 5, 9,
  10} that adds up to T = 22 but not T = 23.\ 

  Find counterexamples to each of the following algorithms for the knapsack
  problem. That is, giving an S and T such that the subset is selected using
  the algorithm does not leave the knapsack completely full, even though such
  a solution exists.

  (a) Put the elements of S in the knapsack in left to right order if they
  fit, i.e. the first-fit algorithm.

  (b) Put the elements of S in the knapsack from smallest to largest, i.e.
  the best-fit algorithm.\ 

  (c) Put the elements of S in the knapsack from largest to smallest.

  <\solution>
    \;

    (a): S = {1 2}, T = 2, result should be {2} not {1}

    (b): S = {1 2 3}, T = 4, result should be {1 3} not {1 2}

    (c): S = {4 3 2}, T = 5, result should be {3 2) not {4}
  </solution>

  \;

  1-6. [5] The set cover problem is as follows: given a set of subsets S1,
  ..., Sm of the universal set U = {1, ..., n}, find the smallest subset of
  subsets T \<subset\> S such that \<cup\>ti\<in\>T ti = U. For example,
  there are the following subsets, S1 = {1, 3, 5}, S2 = {2, 4}, S3 = {1, 4},
  and S4 = {2, 5} The set cover would then be S1 and S2.\ 

  Find a counterexample for the following algorithm: Select the largest
  subset for the cover, and then delete all its elements from the universal
  set. Repeat by adding the subset containing the largest number of uncovered
  elements until all are covered.

  <\solution>
    \;

    U = {1 2 3 4 5 6 7}

    S1 = {1 3 5 7}

    S2 = {1 2 3}

    S3 = {4 5 6 7}

    The optimal solution is S2, S3. But greedy algorithm might pick S1, S2,
    S3.
  </solution>

  \;

  1-7. [3] Prove the correctness of the following recursive algorithm to
  multiply two natural numbers, for all integer constants c \<geq\> 2.

  <\render-code>
    function multiply(y,z)\ 

    comment Return the product yz.\ 

    1. if z = 0 then return(0) else\ 

    2. return(multiply(cy, <math|><math|<around*|\<lfloor\>|z/c|\<rfloor\>>>)
    + y(z mod c))
  </render-code>

  <\proof>
    For basis case when z = 0, then return 0 is true.

    Assume <strong|multiply> work correctly for <math|z \<leq\>n-1>, now the
    case of z = n = ac + m can be dealt with as:

    multiply(cy, a) + ym = yac + ym = y(ac +m) = yz

    thus the general case is resolved.
  </proof>

  \;

  1-10. [3] Prove that <math|<big|sum><rsub|i=1><rsup|n>i=n<around*|(|n+1|)>/2>
  for n \<geq\> 0, by induction.

  <\proof>
    \<#5F53\> n \<#4E3A\>0 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>0\<#FF0C\>\<#7ED3\>\<#679C\>\<#6B63\>\<#786E\>\<#FF1B\>\<#5F53\>
    n = 1 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>1\<#FF0C\>\<#540C\>\<#6837\>\<#6B63\>\<#786E\>\<#3002\>

    \<#5047\>\<#8BBE\>\<#5BF9\>\<#4E8E\> n = k - 1
    \<#6210\>\<#7ACB\>\<#FF0C\>\<#90A3\>\<#4E48\>\<#5BF9\>\<#4E8E\> n = k
    \<#5219\>\<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      k+<around*|(|k-1|)><around*|(|k-1+1|)>/2=k+k<around*|(|k-1|)>/2=k<around*|(|k+1|)>/2=n<around*|(|n+1|)>/2
    </equation*>
  </proof>

  \;

  1-11. [3] Prove that <math|<big|sum><rsup|n><rsub|i=1>i<rsup|2>=n<around*|(|n+1|)><around*|(|2n+1|)>/6>
  for n \<geq\> 0, by induction.

  <\proof>
    \<#5F53\> n = 0 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>0\<#FF0C\>\<#6B63\>\<#786E\>\<#FF1B\>\<#5F53\>
    n = 1 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>1\<#FF0C\>\<#540C\>\<#6837\>\<#6B63\>\<#786E\>\<#3002\>

    \<#5047\>\<#8BBE\>\<#5BF9\>\<#4E8E\> n = k
    \<#6210\>\<#7ACB\>\<#FF0C\>\<#90A3\>\<#4E48\>\<#5BF9\>\<#4E8E\> n = k+1
    \<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      <around*|(|k+1|)><rsup|2>+k<around*|(|k+1|)><around*|(|2k+1|)>/6
    </equation*>

    <\equation*>
      =<around*|(|6<around*|(|k+1|)><rsup|2>+k<around*|(|k+1|)><around*|(|2k+1|)>|)>/6
    </equation*>

    <\equation*>
      =<around*|(|<around*|(|k+1|)><around*|(|6<around*|(|k+1|)>+k<around*|(|2k+1|)>|)>|)>/6
    </equation*>

    <\equation*>
      =<around*|(|k+1|)><around*|(|6k+6+2k<rsup|2>+k|)>/6
    </equation*>

    <\equation*>
      =<around*|(|k+1|)><around*|(|k+2|)><around*|(|2k+3|)>/6
    </equation*>

    <\equation*>
      =<around*|(|k+1|)><around*|(|k+1+1|)><around*|(|2<around*|(|k+1|)>+1|)>/6
    </equation*>

    <\equation*>
      =n<around*|(|n+1|)><around*|(|2n+1|)>/6
    </equation*>
  </proof>

  \;

  1-12. [3] Prove that <math|<big|sum><rsub|i=1><rsup|n>i<rsup|3>=n<rsup|2><around*|(|n+1|)><rsup|2>/4>
  for n \<geq\> 0, by induction.

  <\proof>
    \<#5F53\> n = 0 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>0\<#FF0C\>\<#6B63\>\<#786E\>\<#FF1B\>\<#5F53\>
    n = 1 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>1\<#FF0C\>\<#540C\>\<#6837\>\<#6B63\>\<#786E\>\<#3002\>

    \<#5047\>\<#8BBE\> n = k-1 \<#65F6\>\<#6210\>\<#7ACB\>\<#FF0C\>\<#90A3\>\<#4E48\>\<#5BF9\>\<#4E8E\>
    n =k \<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      k<rsup|3>+<around*|(|k-1|)><rsup|2><around*|(|k-1+1|)><rsup|2>/4
    </equation*>

    <\equation*>
      =k<rsup|3>+<around*|(|k-1|)><rsup|2>k<rsup|2>/4
    </equation*>

    <\equation*>
      =<around*|(|4k<rsup|3>+<around*|(|k-1|)><rsup|2>k<rsup|2>|)>/4
    </equation*>

    <\equation*>
      =k<rsup|2><around*|(|4k+<around*|(|k-1|)><rsup|2>|)>/4
    </equation*>

    <\equation*>
      =k<rsup|2><around*|(|4k+k<rsup|2>-2k+1|)>/4
    </equation*>

    <\equation*>
      =k<rsup|2><around*|(|k+1|)><rsup|2>/4
    </equation*>

    <\equation*>
      =n<rsup|2><around*|(|n+1|)><rsup|2>/4
    </equation*>
  </proof>

  \;

  1-13. [3] Prove that

  <\equation*>
    <above|<below|<above|<big|sum>|n>|i=1>i<around*|(|i+1|)><around*|(|i+2|)>=n<around*|(|n+1|)><around*|(|n+2|)><around*|(|n+3|)>/4|>
  </equation*>

  <\proof>
    \<#5F53\> n = 1 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\>6\<#FF0C\>\<#7ED3\>\<#679C\>\<#6B63\>\<#786E\>\<#3002\>

    \<#5047\>\<#8BBE\>\<#5BF9\>\<#4E8E\> n = k-1
    \<#65F6\>\<#6210\>\<#7ACB\>\<#FF0C\>\<#90A3\>\<#4E48\>\<#5BF9\>\<#4E8E\>
    n = k \<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      k<around*|(|k+1|)><around*|(|k+2|)>+<around*|(|k-1|)><around*|(|k-1+1|)><around*|(|k-1+2|)><around*|(|k-1+3|)>/4
    </equation*>

    <\equation*>
      =k<around*|(|k+1|)><around*|(|k+2|)>+k<around*|(|k-1|)><around*|(|k+1|)><around*|(|k+2|)>/4
    </equation*>

    <\equation*>
      =<around*|(|4k<around*|(|k+1|)><around*|(|k+2|)>+k<around*|(|k-1|)><around*|(|k+1|)><around*|(|k+2|)>|)>/4
    </equation*>

    <\equation*>
      =<around*|(|k+1|)><around*|(|k+2|)><around*|(|k<around*|(|k-1|)>+4k|)>/4
    </equation*>

    <\equation*>
      =<around*|(|k+1|)><around*|(|k+2|)><around*|(|k<rsup|2>-k+4k|)>/4
    </equation*>

    <\equation*>
      =<around*|(|k+1|)><around*|(|k+2|)><around*|(|k<rsup|2>+3k|)>/4
    </equation*>

    <\equation*>
      =k<around*|(|k+1|)><around*|(|k+2|)><around*|(|k+3|)>/4
    </equation*>

    <\equation*>
      =n<around*|(|n+1|)><around*|(|n+2|)><around*|(|n+3|)>/4
    </equation*>
  </proof>

  \;

  1-14. [5] Prove by induction on n \<geq\> 1 that for every
  <name|<math|a\<neq\>1>>\<#FF0C\>

  <\equation*>
    <below|<above||><above|<below|<above|<below|<above|<big|sum>|n>|i=0>a<rsup|i>=|>|><frac|a<rsup|n+1>-1|a-1><text|<em|<strong|<verbatim|>>>>|>|>
  </equation*>

  <\proof>
    \<#5F53\> n = 1 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\><math|<frac|a<rsup|2>-1|a-1>=<frac|<around*|(|a+1|)><around*|(|a-1|)>|a-1>=a+1>\<#FF0C\>\<#7ED3\>\<#679C\>\<#6B63\>\<#786E\>\<#3002\>

    \<#5047\>\<#8BBE\>\<#5BF9\>\<#4E8E\> n = k-1
    \<#65F6\>\<#6210\>\<#7ACB\>\<#FF0C\>\<#5BF9\>\<#4E8E\> n = k
    \<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      a<rsup|k>+<frac|a<rsup|k>-1|a-1>=<frac|a<rsup|k><around*|(|a-1|)>+a<rsup|k>-1|a-1>=<frac|a<rsup|k+1>-1|a-1>=<frac|a<rsup|n+1>-1|a-1>
    </equation*>
  </proof>

  \;

  1-15. [3] Prove by induction that for n \<geq\> 1,

  <\equation*>
    <below|<above|<big|sum>|n>|i=1><frac|1|i<around*|(|i+1|)>>=<frac|n|n+1>
  </equation*>

  <\proof>
    \<#5F53\> n = 1 \<#65F6\>\<#FF0C\>\<#7ED3\>\<#679C\>\<#4E3A\><math|<frac|1|2>>\<#FF0C\>\<#7ED3\>\<#679C\>\<#6B63\>\<#786E\>\<#3002\>

    \<#5047\>\<#8BBE\>\<#5BF9\>\<#4E8E\> n = k-1
    \<#65F6\>\<#6210\>\<#7ACB\>\<#FF0C\>\<#5BF9\>\<#4E8E\> n = k
    \<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      <frac|1|k<around*|(|k+1|)>>+<frac|k-1|<around*|(|k-1|)>+1>
    </equation*>

    <\equation*>
      =<frac|1|k<around*|(|k+1|)>>+<frac|k-1|k>
    </equation*>

    <\equation*>
      =<frac|1+<around*|(|k+1|)><around*|(|k-1|)>|k<around*|(|k+1|)>>
    </equation*>

    <\equation*>
      =<frac|1+k<rsup|2>-1|k<around*|(|k+1|)>>
    </equation*>

    <\equation*>
      =<frac|k<rsup|2>|k<around*|(|k+1|)>>
    </equation*>

    <\equation*>
      =<frac|k|k+1>
    </equation*>

    <\equation*>
      =<frac|n|n+1>
    </equation*>
  </proof>

  \;

  1-16. [3] Prove by induction that <math|n<rsup|3>+2n> is divisible by 3 for
  all n \<geq\> 0.

  <\proof>
    \<#5F53\> n = 1 \<#65F6\>\<#FF0C\>\<#8868\>\<#8FBE\>\<#5F0F\>\<#7684\>\<#503C\>\<#4E3A\>3\<#FF0C\>\<#53EF\>\<#4EE5\>\<#88AB\>3\<#6574\>\<#9664\>\<#3002\>

    \<#5047\>\<#8BBE\>\<#5BF9\>\<#4E8E\> n = k
    \<#6210\>\<#7ACB\>\<#FF0C\>\<#90A3\>\<#4E48\>\<#5BF9\>\<#4E8E\> n =
    k+1\<#FF0C\>\<#8868\>\<#8FBE\>\<#5F0F\>\<#53EF\>\<#4EE5\>\<#8868\>\<#793A\>\<#4E3A\>\<#FF1A\>

    <\equation*>
      <around*|(|k+1|)><rsup|3>+2<around*|(|k+1|)>=k<rsup|3>+3k<rsup|2>+3k+1+2k+2=<around*|(|k<rsup|3>+2k|)>+<around*|(|3k<rsup|2>+3k+3|)>
    </equation*>

    \<#6839\>\<#636E\>\<#5047\>\<#8BBE\>\<#FF0C\>\<#5BF9\>\<#4E8E\> n = k
    \<#7B49\>\<#5F0F\>\<#6210\>\<#7ACB\>\<#FF0C\>\<#6240\>\<#4EE5\>
    <math|k<rsup|3>+2k> \<#53EF\>\<#4EE5\>\<#88AB\>3\<#6574\>\<#9664\>\<#FF0C\>\<#800C\>
    <math|3k<rsup|2>+3k+3> \<#6BCF\>\<#4E00\>\<#9879\>\<#90FD\>\<#53EF\>\<#4EE5\>\<#88AB\>3\<#6574\>\<#9664\>\<#FF0C\>\<#6240\>\<#4EE5\>\<#6574\>\<#4E2A\>\<#8868\>\<#8FBE\>\<#5F0F\>\<#53EF\>\<#4EE5\>\<#88AB\>3\<#6574\>\<#9664\>\<#3002\>
  </proof>
</body>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
  </collection>
</references>