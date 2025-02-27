use cairo_lib::data_structures::mmr::proof::{Proof, ProofTrait};
use cairo_lib::hashing::poseidon::PoseidonHasher;
use array::{ArrayTrait, SpanTrait};

fn helper_test_get_elements() -> Span<felt252> {
    let elem1 = PoseidonHasher::hash_double(1, 1);
    let elem2 = PoseidonHasher::hash_double(2, 2);
    let elem3 = PoseidonHasher::hash_double(3, PoseidonHasher::hash_double(elem1, elem2));
    let elem4 = PoseidonHasher::hash_double(4, 4);
    let elem5 = PoseidonHasher::hash_double(5, 5);
    let elem6 = PoseidonHasher::hash_double(6, PoseidonHasher::hash_double(elem4, elem5));
    let elem7 = PoseidonHasher::hash_double(7, PoseidonHasher::hash_double(elem3, elem6));
    let elem8 = PoseidonHasher::hash_double(8, 8);

    let arr = array![elem1, elem2, elem3, elem4, elem5, elem6, elem7, elem8];
    arr.span()
}

#[test]
#[available_gas(99999999)]
fn test_compute_peak_all_left() {
    let elems = helper_test_get_elements();

    let proof_arr = array![*elems.at(1), *elems.at(5)];
    let proof: Proof = proof_arr.span();

    let computed_peak = proof.compute_peak(1, 1);
    assert(computed_peak == *elems.at(6), 'Wrong computed all left peak');
}

#[test]
#[available_gas(99999999)]
fn test_compute_peak_all_right() {
    let elems = helper_test_get_elements();

    let proof_arr = array![*elems.at(3), *elems.at(2)];
    let proof: Proof = proof_arr.span();

    let computed_peak = proof.compute_peak(5, 5);
    assert(computed_peak == *elems.at(6), 'Wrong computed all right peak');
}

#[test]
#[available_gas(99999999)]
fn test_compute_peak_left_right() {
    let elems = helper_test_get_elements();

    let proof_arr = array![*elems.at(0), *elems.at(5)];
    let proof: Proof = proof_arr.span();

    let computed_peak = proof.compute_peak(2, 2);
    assert(computed_peak == *elems.at(6), 'Wrong computed left right peak');
}
