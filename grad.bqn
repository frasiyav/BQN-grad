# Math functions
MM ← +˝∘×⎉1‿∞
TH ← 1(-÷+)˜·⋆2×⊢
Rl ← 0(⌈+0.001×⌊)⊢ ⋄ Rld ← 0(<+0.001×>)⊢
SG ← ÷1+⋆∘-
CE ← +˝-⊸×⟜(⋆⁼)
CS ← CE⟜(÷⟜(+´⥊)○⋆)
  
Val   ⇐ {u𝕊v: {𝕊: v; 𝕊⁼: v U↩ 𝕩 ⋄ @ }} # takes a fn U to update state based on gradient recieved
Const ⇐ { 𝕊c: {𝕊: c; 𝕊⁼: @          }}

_Op ← {Op _𝕣: { # wrap each instance of an operation to keep track of results
  𝕊a: # mondaic case
    sx‿fx←0‿0             # 𝕊(x) F(x)
    F←{𝕊: fx↩A𝕩; 𝕊⁼: A⁼𝕩} # map A to F which saves its result when called
    S←{sx↩𝕩}              # save own result
    R←{𝕤⋄sx‿fx}           # read states
    Op f‿s‿r
    ;
  a𝕊b: # dyadic case
    sx‿fx‿gx ← 0‿0‿0      # 𝕊(x) F(x) G(x)
    F←{𝕊: fx↩A𝕩; 𝕊⁼: A⁼𝕩} # map A to F
    G←{𝕊: gx↩B𝕩; 𝕊⁼: B⁼𝕩} # map B to G
    S←{sx↩𝕩}
    R←{𝕤⋄sx‿fx‿gx}
    Op f‿g‿s‿r
}}

_dx_ ← {F _𝕣_ G: {𝕊: F𝕩; 𝕊⁼:G𝕩}}

# operations
Add ⇐ {𝕊f‿g‿s‿r: S∘(F+G)    _dx_ {                F⁼ 𝕩              ⋄ G⁼ 𝕩                 }}_Op 
Sub ⇐ {𝕊f‿g‿s‿r: S∘(F-G)    _dx_ {                F⁼ 𝕩              ⋄ G⁼ 𝕩 × ¯1            }}_Op
Mul ⇐ {𝕊f‿g‿s‿r: S∘(F×G)    _dx_ { ·‿fx‿gx ← R@ ⋄ F⁼ 𝕩 × gx         ⋄ G⁼ 𝕩 × fx            }}_Op
Div ⇐ {𝕊f‿g‿s‿r: S∘(F÷G)    _dx_ { ·‿fx‿gx ← R@ ⋄ F⁼ 𝕩 × ÷gx        ⋄ G⁼ 𝕩 × -fx÷gx⋆2      }}_Op
Pow ⇐ {𝕊f‿g‿s‿r: S∘(F⋆G)    _dx_ {sx‿fx‿gx ← R@ ⋄ F⁼ 𝕩 × gx×fx⋆gx-1 ⋄ G⁼ 𝕩 × sx×⋆⁼fx       }}_Op
MMul⇐ {𝕊f‿g‿s‿r: S∘(F MM G) _dx_ { ·‿fx‿gx ← R@ ⋄ F⁼ 𝕩 MM⟜⍉ gx      ⋄ G⁼ 𝕩 MM˜⟜⍉ fx        }}_Op
Exp ⇐ {𝕊f‿s‿r:   S∘(⋆F)     _dx_ {sx‿ ·    ← R@ ⋄ F⁼ 𝕩 × sx                                }}_Op
Sig ⇐ {𝕊f‿s‿r:   S∘(SG F)   _dx_ {sx‿ ·    ← R@ ⋄ F⁼ 𝕩 × sx×1-sx                           }}_Op
Tanh⇐ {𝕊f‿s‿r:   S∘(TH F)   _dx_ {sx‿ ·    ← R@ ⋄ F⁼ 𝕩 × 1-sx⋆2                            }}_Op
Relu⇐ {𝕊f‿s‿r:   S∘(RL F)   _dx_ { ·‿fx    ← R@ ⋄ F⁼ 𝕩 × RLd fx                            }}_Op
CSE ⇐ {𝕊f‿g‿s‿r: S∘(F CE G) _dx_ { ·‿fx‿gx ← R@ ⋄                     G⁼ 𝕩 ×-fx÷gx         }}_Op
CCE ⇐ {𝕊f‿g‿s‿r: S∘(F CS G) _dx_ { ·‿fx‿gx ← R@ ⋄                     G⁼ 𝕩 × gx-fx         }}_Op

grad ⇐ •ReBQN {
  primitives⇐⟨
    '+'‿Add, '*'‿Mul, '-'‿Sub, '⋆'‿(Exp⊘Pow), '÷'‿Div, '×'‿MMul,
    'τ'‿Tanh, 'ρ'‿Relu, 'σ'‿Sig, 'υ'‿CSE, 'φ'‿CCE,
    '≠'‿(≠∘⊢), '⊣'‿⊣, '⊢'‿⊢, '∾'‿∾, '⋈'‿⋈, '⌽'‿⌽, '⊏'‿⊏, '⊑'‿⊑, '˜'‿˜, '¨'‿¨   
    '%'‿Val, '$'‿Const
  ⟩∾¯14↑•primitives
# scope⇐"read" #NYI
}
