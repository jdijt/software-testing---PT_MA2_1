# Assignment 8 Counterexample

*Question:* Is there a difference between the symmetric closure of the transitive closure of a relation R and the transitive closure of the symmetric closure of R?

*Answer:* Yes, (R<sup>+</sup>)<sup>s</sup> &ne; (R<sup>s</sup>)<sup>+</sup> where R<sup>s</sup> is the symmetric closure of R.

**(R<sup>+</sup>)<sup>s</sup>**

- Take R = {(0,1)}
- R<sup>+</sup> = {(0,1)}
- (R<sup>+</sup>)<sup>s</sup> =  **{(0,1),(1,0)}**

**(R<sup>s</sup>)<sup>+</sup>**

- Take R = {(0,1)}
- R<sup>s</sup> = {(0,1),(1,0)}
- (R<sup>s</sup>)<sup>+</sup> =  **{(0,1),(1,0),(1,1),(0,0)}**
