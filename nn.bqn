⟨Val,Const,Grad⟩ ← •Import "grad.bqn"

R2 ← ⍉0‿0⊸↓
Chunk ← ⌊∘÷˜⟜(↕≠)⊔⊢

tN ← 10000  # training examples  Max 60000
vN ← 1000   # testing examples   Max 60000
eN ← 10     # number of epochs

x ← Const∘R2∘⥊˘ 255÷˜ tN↑ ∘‿28‿28⥊16↓@-˜•Fbytes "qmnist/qmnist-train-images-idx3-ubyte"
vx ← Const∘R2∘⥊˘ 255÷˜ vN↑ ∘‿28‿28⥊16↓@-˜•Fbytes "qmnist/qmnist-test-images-idx3-ubyte"
y ← (Const∘R2 10↑·/⁼≍)˘ tN↑ ⊑˘∘‿8⥊+´˘∘‿4⥊12↓@-˜•Fbytes "qmnist/qmnist-train-labels-idx2-int"
vy ← vN↑8↓@-˜•Fbytes "qmnist/qmnist-test-labels-idx1-ubyte"

Bias   ← {𝕤⋄p←0 ⋄ {p←𝕩 ⋄ 𝕨-(0.5×p)+0.05×𝕩}} Val ⊢
Weight ← {𝕤⋄p←0 ⋄ {p←𝕩 ⋄ 𝕨-(0.5×p)+0.025×𝕩}} Val ⊢

RNorm ← {(√¯2×⋆⁼)⊸×⟜(•math.Cos 2×π×⊢)´𝕩⊸•rand.Range¨0‿0}

InitLayer ← {⟨ 
  Weight  RNorm⊸÷⟜20 ⌽𝕩,
  Bias R2 RNorm⊸÷⟜20 1⊑𝕩
⟩}
MLP ← <∘InitLayer˘2↕⊢

layers ← MLP 784‿32‿16‿10

network ← Grad "{
  ⟨w1‿b1,w2‿b2,w3‿b3⟩ 𝕊 in:
    l1 ← ρ b1 + w1 × in
    l2 ← ρ b2 + w2 × l1
    b3 + w3 × l2
}"
NN ← layers⊸Network

l ← Grad "{
  y 𝔽_𝕣 x:
    (+´÷·$≠) y φ⟜𝔽¨ x
}"
Loss ← NN _l

batches ← Loss¨´50⊸Chunk¨y‿x
Acc ← {𝕤⋄(+´÷≠)vy{𝕨=⊑⍒{𝕏@} NN 𝕩}¨vx}
{{1⌾𝕏@}¨batches ⋄ •Show "Epoch "∾(•Fmt𝕩)∾": "∾•Fmt Acc@}¨↕eN
