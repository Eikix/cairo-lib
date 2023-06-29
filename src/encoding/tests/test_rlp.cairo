use cairo_lib::encoding::rlp::{rlp_decode, RLPType, RLPTypeTrait, RLPItem};
use cairo_lib::utils::types::bytes::Bytes;
use array::{ArrayTrait, SpanTrait};
use result::ResultTrait;

#[test]
#[available_gas(9999999)]
fn test_rlp_types() {
    let mut i = 0;
    loop {
        if i <= 0x7f {
            assert(RLPTypeTrait::from_byte(i).unwrap() == RLPType::String(()), 'Parse type String');
        } else if i <= 0xb7 {
            assert(RLPTypeTrait::from_byte(i).unwrap() == RLPType::StringShort(()), 'Parse type StringShort');
        } else if i <= 0xbf {
            assert(RLPTypeTrait::from_byte(i).unwrap() == RLPType::StringLong(()), 'Parse type StringLong');
        } else if i <= 0xf7 {
            assert(RLPTypeTrait::from_byte(i).unwrap() == RLPType::ListShort(()), 'Parse type ListShort');
        } else if i <= 0xff {
            assert(RLPTypeTrait::from_byte(i).unwrap() == RLPType::ListLong(()), 'Parse type ListLong');
        }

        if i == 0xff {
            break ();
        }
        i += 1;
    };
}

#[test]
#[available_gas(99999999)]
fn test_rlp_decode_string() {
    let mut i = 0;
    loop {
        if i == 0x80 {
            break ();
        }
        let mut arr = ArrayTrait::new();
        arr.append(i);

        let (res, len) = rlp_decode(arr.span()).unwrap();
        assert(len == 1, 'Wrong len');
        assert(res == RLPItem::Bytes(arr.span()), 'Wrong value');

        i += 1;
    };
}

#[test]
#[available_gas(99999999)]
fn test_rlp_decode_short_string() {
    let mut arr = ArrayTrait::new();
    arr.append(0x9b);
    arr.append(0x5a);
    arr.append(0x80);
    arr.append(0x6c);
    arr.append(0xf6);
    arr.append(0x34);
    arr.append(0xc0);
    arr.append(0x39);
    arr.append(0x8d);
    arr.append(0x8f);
    arr.append(0x2d);
    arr.append(0x89);
    arr.append(0xfd);
    arr.append(0x49);
    arr.append(0xa9);
    arr.append(0x1e);
    arr.append(0xf3);
    arr.append(0x3d);
    arr.append(0xa4);
    arr.append(0x74);
    arr.append(0xcd);
    arr.append(0x84);
    arr.append(0x94);
    arr.append(0xbb);
    arr.append(0xa8);
    arr.append(0xda);
    arr.append(0x3b);
    arr.append(0xf7);

    let (res, len) = rlp_decode(arr.span()).unwrap();
    assert(len == 1 + (0x9b-0x80), 'Wrong len');

    arr.pop_front();
    let expected_item = RLPItem::Bytes(arr.span());

    assert(res == expected_item, 'Wrong value');
}

#[test]
#[available_gas(99999999)]
fn test_rlp_decode_long_string_len_of_len_1() {
    let mut arr = ArrayTrait::new();
    arr.append(0xb8);
    arr.append(0x3c);
    arr.append(0xf7);
    arr.append(0xa1);
    arr.append(0x7e);
    arr.append(0xf9);
    arr.append(0x59);
    arr.append(0xd4);
    arr.append(0x88);
    arr.append(0x38);
    arr.append(0x8d);
    arr.append(0xdc);
    arr.append(0x34);
    arr.append(0x7b);
    arr.append(0x3a);
    arr.append(0x10);
    arr.append(0xdd);
    arr.append(0x85);
    arr.append(0x43);
    arr.append(0x1d);
    arr.append(0x0c);
    arr.append(0x37);
    arr.append(0x98);
    arr.append(0x6a);
    arr.append(0x63);
    arr.append(0xbd);
    arr.append(0x18);
    arr.append(0xba);
    arr.append(0xa3);
    arr.append(0x8d);
    arr.append(0xb1);
    arr.append(0xa4);
    arr.append(0x81);
    arr.append(0x6f);
    arr.append(0x24);
    arr.append(0xde);
    arr.append(0xc3);
    arr.append(0xec);
    arr.append(0x16);
    arr.append(0x6e);
    arr.append(0xb3);
    arr.append(0xb2);
    arr.append(0xac);
    arr.append(0xc4);
    arr.append(0xc4);
    arr.append(0xf7);
    arr.append(0x79);
    arr.append(0x04);
    arr.append(0xba);
    arr.append(0x76);
    arr.append(0x3c);
    arr.append(0x67);
    arr.append(0xc6);
    arr.append(0xd0);
    arr.append(0x53);
    arr.append(0xda);
    arr.append(0xea);
    arr.append(0x10);
    arr.append(0x86);
    arr.append(0x19);
    arr.append(0x7d);
    arr.append(0xd9);
    
    let (res, len) = rlp_decode(arr.span()).unwrap();
    assert(len == 1 + (0xb8-0xb7) + 0x3c, 'Wrong len');

    arr.pop_front();
    arr.pop_front();
    let expected_item = RLPItem::Bytes(arr.span());

    assert(res == expected_item, 'Wrong value');
}

#[test]
#[available_gas(99999999)]
fn test_rlp_decode_long_string_len_of_len_2() {
    let mut arr = ArrayTrait::new();
    arr.append(0xb9);
    arr.append(0x01);
    arr.append(0x02);
    arr.append(0xf7);
    arr.append(0xa1);
    arr.append(0x7e);
    arr.append(0xf9);
    arr.append(0x59);
    arr.append(0xd4);
    arr.append(0x88);
    arr.append(0x38);
    arr.append(0x8d);
    arr.append(0xdc);
    arr.append(0x34);
    arr.append(0x7b);
    arr.append(0x3a);
    arr.append(0x10);
    arr.append(0xdd);
    arr.append(0x85);
    arr.append(0x43);
    arr.append(0x1d);
    arr.append(0x0c);
    arr.append(0x37);
    arr.append(0x98);
    arr.append(0x6a);
    arr.append(0x63);
    arr.append(0xbd);
    arr.append(0x18);
    arr.append(0xba);
    arr.append(0xa3);
    arr.append(0x8d);
    arr.append(0xb1);
    arr.append(0xa4);
    arr.append(0x81);
    arr.append(0x6f);
    arr.append(0x24);
    arr.append(0xde);
    arr.append(0xc3);
    arr.append(0xec);
    arr.append(0x16);
    arr.append(0x6e);
    arr.append(0xb3);
    arr.append(0xb2);
    arr.append(0xac);
    arr.append(0xc4);
    arr.append(0xc4);
    arr.append(0xf7);
    arr.append(0x79);
    arr.append(0x04);
    arr.append(0xba);
    arr.append(0x76);
    arr.append(0x3c);
    arr.append(0x67);
    arr.append(0xc6);
    arr.append(0xd0);
    arr.append(0x53);
    arr.append(0xda);
    arr.append(0xea);
    arr.append(0x10);
    arr.append(0x86);
    arr.append(0x19);
    arr.append(0x7d);
    arr.append(0xd9);
    arr.append(0x33);
    arr.append(0x58);
    arr.append(0x47);
    arr.append(0x69);
    arr.append(0x34);
    arr.append(0x76);
    arr.append(0x89);
    arr.append(0x43);
    arr.append(0x67);
    arr.append(0x93);
    arr.append(0x45);
    arr.append(0x76);
    arr.append(0x87);
    arr.append(0x34);
    arr.append(0x95);
    arr.append(0x67);
    arr.append(0x89);
    arr.append(0x34);
    arr.append(0x36);
    arr.append(0x43);
    arr.append(0x86);
    arr.append(0x79);
    arr.append(0x43);
    arr.append(0x63);
    arr.append(0x34);
    arr.append(0x78);
    arr.append(0x63);
    arr.append(0x49);
    arr.append(0x58);
    arr.append(0x67);
    arr.append(0x83);
    arr.append(0x59);
    arr.append(0x64);
    arr.append(0x56);
    arr.append(0x37);
    arr.append(0x93);
    arr.append(0x74);
    arr.append(0x58);
    arr.append(0x69);
    arr.append(0x69);
    arr.append(0x43);
    arr.append(0x67);
    arr.append(0x39);
    arr.append(0x48);
    arr.append(0x67);
    arr.append(0x98);
    arr.append(0x45);
    arr.append(0x63);
    arr.append(0x89);
    arr.append(0x45);
    arr.append(0x67);
    arr.append(0x94);
    arr.append(0x37);
    arr.append(0x63);
    arr.append(0x04);
    arr.append(0x56);
    arr.append(0x40);
    arr.append(0x39);
    arr.append(0x68);
    arr.append(0x43);
    arr.append(0x08);
    arr.append(0x68);
    arr.append(0x40);
    arr.append(0x65);
    arr.append(0x03);
    arr.append(0x46);
    arr.append(0x80);
    arr.append(0x93);
    arr.append(0x48);
    arr.append(0x64);
    arr.append(0x95);
    arr.append(0x36);
    arr.append(0x87);
    arr.append(0x39);
    arr.append(0x84);
    arr.append(0x56);
    arr.append(0x73);
    arr.append(0x76);
    arr.append(0x89);
    arr.append(0x34);
    arr.append(0x95);
    arr.append(0x86);
    arr.append(0x73);
    arr.append(0x65);
    arr.append(0x40);
    arr.append(0x93);
    arr.append(0x60);
    arr.append(0x98);
    arr.append(0x34);
    arr.append(0x56);
    arr.append(0x83);
    arr.append(0x04);
    arr.append(0x56);
    arr.append(0x80);
    arr.append(0x36);
    arr.append(0x08);
    arr.append(0x59);
    arr.append(0x68);
    arr.append(0x45);
    arr.append(0x06);
    arr.append(0x83);
    arr.append(0x06);
    arr.append(0x68);
    arr.append(0x40);
    arr.append(0x59);
    arr.append(0x68);
    arr.append(0x40);
    arr.append(0x65);
    arr.append(0x84);
    arr.append(0x03);
    arr.append(0x68);
    arr.append(0x30);
    arr.append(0x48);
    arr.append(0x65);
    arr.append(0x03);
    arr.append(0x46);
    arr.append(0x83);
    arr.append(0x49);
    arr.append(0x57);
    arr.append(0x68);
    arr.append(0x95);
    arr.append(0x79);
    arr.append(0x68);
    arr.append(0x34);
    arr.append(0x76);
    arr.append(0x83);
    arr.append(0x74);
    arr.append(0x69);
    arr.append(0x87);
    arr.append(0x43);
    arr.append(0x59);
    arr.append(0x63);
    arr.append(0x84);
    arr.append(0x75);
    arr.append(0x63);
    arr.append(0x98);
    arr.append(0x47);
    arr.append(0x56);
    arr.append(0x34);
    arr.append(0x86);
    arr.append(0x73);
    arr.append(0x94);
    arr.append(0x87);
    arr.append(0x65);
    arr.append(0x43);
    arr.append(0x98);
    arr.append(0x67);
    arr.append(0x34);
    arr.append(0x96);
    arr.append(0x79);
    arr.append(0x34);
    arr.append(0x86);
    arr.append(0x57);
    arr.append(0x93);
    arr.append(0x48);
    arr.append(0x57);
    arr.append(0x69);
    arr.append(0x34);
    arr.append(0x87);
    arr.append(0x56);
    arr.append(0x89);
    arr.append(0x34);
    arr.append(0x57);
    arr.append(0x68);
    arr.append(0x73);
    arr.append(0x49);
    arr.append(0x56);
    arr.append(0x53);
    arr.append(0x79);
    arr.append(0x43);
    arr.append(0x95);
    arr.append(0x67);
    arr.append(0x34);
    arr.append(0x96);
    arr.append(0x79);
    arr.append(0x38);
    arr.append(0x47);
    arr.append(0x63);
    arr.append(0x94);
    arr.append(0x65);
    arr.append(0x37);
    arr.append(0x89);
    arr.append(0x63);
    arr.append(0x53);
    arr.append(0x45);
    arr.append(0x68);
    arr.append(0x79);
    arr.append(0x88);
    arr.append(0x97);
    arr.append(0x68);
    arr.append(0x87);
    arr.append(0x68);
    arr.append(0x68);
    arr.append(0x68);
    arr.append(0x76);
    arr.append(0x99);
    arr.append(0x87);
    arr.append(0x60);
    
    let (res, len) = rlp_decode(arr.span()).unwrap();
    assert(len == 1 + (0xb9-0xb7) + 0x0102, 'Wrong len');

    arr.pop_front();
    arr.pop_front();
    arr.pop_front();
    let expected_item = RLPItem::Bytes(arr.span());

    assert(res == expected_item, 'Wrong value');
}

#[test]
#[available_gas(99999999999)]
fn test_rlp_decode_short_list() {
    let mut arr = ArrayTrait::new();
    arr.append(0xc9);
    arr.append(0x83);
    arr.append(0x35);
    arr.append(0x35);
    arr.append(0x89);
    arr.append(0x42);
    arr.append(0x83);
    arr.append(0x45);
    arr.append(0x38);
    arr.append(0x92);

    let (res, len) = rlp_decode(arr.span()).unwrap();
    assert(len == 1 + (0xc9-0xc0), 'Wrong len');

    let mut expected = ArrayTrait::new();

    let mut expected_0 = ArrayTrait::new();
    expected_0.append(0x35);
    expected_0.append(0x35);
    expected_0.append(0x89);
    expected.append(expected_0.span());

    let mut expected_1 = ArrayTrait::new();
    expected_1.append(0x42);
    expected.append(expected_1.span());

    let mut expected_2 = ArrayTrait::new();
    expected_2.append(0x45);
    expected_2.append(0x38);
    expected_2.append(0x92);
    expected.append(expected_2.span());

    let expected_item = RLPItem::List(expected.span());

    assert(res == expected_item, 'Wrong value');
}

#[test]
#[available_gas(99999999999)]
fn test_rlp_decode_long_list() {
    let mut arr = ArrayTrait::new();
    arr.append(0xf9);
    arr.append(0x02);
    arr.append(0x11);
    arr.append(0xa0);
    arr.append(0x77);
    arr.append(0x70);
    arr.append(0xcf);
    arr.append(0x09);
    arr.append(0xb5);
    arr.append(0x06);
    arr.append(0x7a);
    arr.append(0x1b);
    arr.append(0x35);
    arr.append(0xdf);
    arr.append(0x62);
    arr.append(0xa9);
    arr.append(0x24);
    arr.append(0x89);
    arr.append(0x81);
    arr.append(0x75);
    arr.append(0xce);
    arr.append(0xae);
    arr.append(0xec);
    arr.append(0xad);
    arr.append(0x1f);
    arr.append(0x68);
    arr.append(0xcd);
    arr.append(0xb4);
    arr.append(0xa8);
    arr.append(0x44);
    arr.append(0x40);
    arr.append(0x0c);
    arr.append(0x73);
    arr.append(0xc1);
    arr.append(0x4a);
    arr.append(0xf4);
    arr.append(0xa0);
    arr.append(0x1e);
    arr.append(0xa3);
    arr.append(0x85);
    arr.append(0xd0);
    arr.append(0x5a);
    arr.append(0xb2);
    arr.append(0x61);
    arr.append(0x46);
    arr.append(0x6d);
    arr.append(0x5c);
    arr.append(0x04);
    arr.append(0x87);
    arr.append(0xfe);
    arr.append(0x68);
    arr.append(0x45);
    arr.append(0x34);
    arr.append(0xc1);
    arr.append(0x9f);
    arr.append(0x1a);
    arr.append(0x4b);
    arr.append(0x5c);
    arr.append(0x4b);
    arr.append(0x18);
    arr.append(0xdc);
    arr.append(0x1a);
    arr.append(0x36);
    arr.append(0x35);
    arr.append(0x60);
    arr.append(0x02);
    arr.append(0x50);
    arr.append(0x71);
    arr.append(0xb4);
    arr.append(0xa0);
    arr.append(0x2c);
    arr.append(0x4c);
    arr.append(0x04);
    arr.append(0xce);
    arr.append(0x35);
    arr.append(0x40);
    arr.append(0xd3);
    arr.append(0xd1);
    arr.append(0x46);
    arr.append(0x18);
    arr.append(0x72);
    arr.append(0x30);
    arr.append(0x3c);
    arr.append(0x53);
    arr.append(0xa5);
    arr.append(0xe5);
    arr.append(0x66);
    arr.append(0x83);
    arr.append(0xc1);
    arr.append(0x30);
    arr.append(0x4f);
    arr.append(0x8d);
    arr.append(0x36);
    arr.append(0xa8);
    arr.append(0x80);
    arr.append(0x0c);
    arr.append(0x6a);
    arr.append(0xf5);
    arr.append(0xfa);
    arr.append(0x3f);
    arr.append(0xcd);
    arr.append(0xee);
    arr.append(0xa0);
    arr.append(0xa9);
    arr.append(0xdc);
    arr.append(0x77);
    arr.append(0x8d);
    arr.append(0xc5);
    arr.append(0x4b);
    arr.append(0x7d);
    arr.append(0xd3);
    arr.append(0xc4);
    arr.append(0x82);
    arr.append(0x22);
    arr.append(0xe7);
    arr.append(0x39);
    arr.append(0xd1);
    arr.append(0x61);
    arr.append(0xfe);
    arr.append(0xb0);
    arr.append(0xc0);
    arr.append(0xee);
    arr.append(0xce);
    arr.append(0xb2);
    arr.append(0xdc);
    arr.append(0xd5);
    arr.append(0x17);
    arr.append(0x37);
    arr.append(0xf0);
    arr.append(0x5b);
    arr.append(0x8e);
    arr.append(0x37);
    arr.append(0xa6);
    arr.append(0x38);
    arr.append(0x51);
    arr.append(0xa0);
    arr.append(0xa9);
    arr.append(0x5f);
    arr.append(0x4d);
    arr.append(0x55);
    arr.append(0x56);
    arr.append(0xdf);
    arr.append(0x62);
    arr.append(0xdd);
    arr.append(0xc2);
    arr.append(0x62);
    arr.append(0x99);
    arr.append(0x04);
    arr.append(0x97);
    arr.append(0xae);
    arr.append(0x56);
    arr.append(0x9b);
    arr.append(0xcd);
    arr.append(0x8e);
    arr.append(0xfd);
    arr.append(0xda);
    arr.append(0x7b);
    arr.append(0x20);
    arr.append(0x07);
    arr.append(0x93);
    arr.append(0xf8);
    arr.append(0xd3);
    arr.append(0xde);
    arr.append(0x4c);
    arr.append(0xdb);
    arr.append(0x97);
    arr.append(0x18);
    arr.append(0xd7);
    arr.append(0xa0);
    arr.append(0x39);
    arr.append(0xd4);
    arr.append(0x06);
    arr.append(0x6d);
    arr.append(0x14);
    arr.append(0x38);
    arr.append(0x22);
    arr.append(0x6e);
    arr.append(0xaf);
    arr.append(0x4a);
    arr.append(0xc9);
    arr.append(0xe9);
    arr.append(0x43);
    arr.append(0xa8);
    arr.append(0x74);
    arr.append(0xa9);
    arr.append(0xa9);
    arr.append(0xc2);
    arr.append(0x5f);
    arr.append(0xb0);
    arr.append(0xd8);
    arr.append(0x1d);
    arr.append(0xb9);
    arr.append(0x86);
    arr.append(0x1d);
    arr.append(0x8c);
    arr.append(0x13);
    arr.append(0x36);
    arr.append(0xb3);
    arr.append(0xe2);
    arr.append(0x03);
    arr.append(0x4c);
    arr.append(0xa0);
    arr.append(0x7a);
    arr.append(0xcc);
    arr.append(0x7c);
    arr.append(0x63);
    arr.append(0xb4);
    arr.append(0x6a);
    arr.append(0xa4);
    arr.append(0x18);
    arr.append(0xb3);
    arr.append(0xc9);
    arr.append(0xa0);
    arr.append(0x41);
    arr.append(0xa1);
    arr.append(0x25);
    arr.append(0x6b);
    arr.append(0xcb);
    arr.append(0x73);
    arr.append(0x61);
    arr.append(0x31);
    arr.append(0x6b);
    arr.append(0x39);
    arr.append(0x7a);
    arr.append(0xda);
    arr.append(0x5a);
    arr.append(0x88);
    arr.append(0x67);
    arr.append(0x49);
    arr.append(0x1b);
    arr.append(0xbb);
    arr.append(0x13);
    arr.append(0x01);
    arr.append(0x30);
    arr.append(0xa0);
    arr.append(0x15);
    arr.append(0x35);
    arr.append(0x8a);
    arr.append(0x81);
    arr.append(0x25);
    arr.append(0x2e);
    arr.append(0xc4);
    arr.append(0x93);
    arr.append(0x71);
    arr.append(0x13);
    arr.append(0xfe);
    arr.append(0x36);
    arr.append(0xc7);
    arr.append(0x80);
    arr.append(0x46);
    arr.append(0xb7);
    arr.append(0x11);
    arr.append(0xfb);
    arr.append(0xa1);
    arr.append(0x97);
    arr.append(0x34);
    arr.append(0x91);
    arr.append(0xbb);
    arr.append(0x29);
    arr.append(0x18);
    arr.append(0x7a);
    arr.append(0x00);
    arr.append(0x78);
    arr.append(0x5f);
    arr.append(0xf8);
    arr.append(0x52);
    arr.append(0xae);
    arr.append(0xa0);
    arr.append(0x68);
    arr.append(0x91);
    arr.append(0x42);
    arr.append(0xd3);
    arr.append(0x16);
    arr.append(0xab);
    arr.append(0xfa);
    arr.append(0xa7);
    arr.append(0x1c);
    arr.append(0x8b);
    arr.append(0xce);
    arr.append(0xdf);
    arr.append(0x49);
    arr.append(0x20);
    arr.append(0x1d);
    arr.append(0xdb);
    arr.append(0xb2);
    arr.append(0x10);
    arr.append(0x4e);
    arr.append(0x25);
    arr.append(0x0a);
    arr.append(0xdc);
    arr.append(0x90);
    arr.append(0xc4);
    arr.append(0xe8);
    arr.append(0x56);
    arr.append(0x22);
    arr.append(0x1f);
    arr.append(0x53);
    arr.append(0x4a);
    arr.append(0x96);
    arr.append(0x58);
    arr.append(0xa0);
    arr.append(0xdc);
    arr.append(0x36);
    arr.append(0x50);
    arr.append(0x99);
    arr.append(0x25);
    arr.append(0x34);
    arr.append(0xfd);
    arr.append(0xa8);
    arr.append(0xa3);
    arr.append(0x14);
    arr.append(0xa7);
    arr.append(0xdb);
    arr.append(0xb0);
    arr.append(0xae);
    arr.append(0x3b);
    arr.append(0xa8);
    arr.append(0xc7);
    arr.append(0x9d);
    arr.append(0xb5);
    arr.append(0x55);
    arr.append(0x0c);
    arr.append(0x69);
    arr.append(0xce);
    arr.append(0x2a);
    arr.append(0x24);
    arr.append(0x60);
    arr.append(0xc0);
    arr.append(0x07);
    arr.append(0xad);
    arr.append(0xc4);
    arr.append(0xc1);
    arr.append(0xa3);
    arr.append(0xa0);
    arr.append(0x20);
    arr.append(0xb0);
    arr.append(0x68);
    arr.append(0x3b);
    arr.append(0x66);
    arr.append(0x55);
    arr.append(0xb0);
    arr.append(0x05);
    arr.append(0x9e);
    arr.append(0xe1);
    arr.append(0x03);
    arr.append(0xd0);
    arr.append(0x4e);
    arr.append(0x4b);
    arr.append(0x50);
    arr.append(0x6b);
    arr.append(0xcb);
    arr.append(0xc1);
    arr.append(0x39);
    arr.append(0x00);
    arr.append(0x63);
    arr.append(0x92);
    arr.append(0xb7);
    arr.append(0xda);
    arr.append(0xb1);
    arr.append(0x11);
    arr.append(0x78);
    arr.append(0xc2);
    arr.append(0x66);
    arr.append(0x03);
    arr.append(0x42);
    arr.append(0xe7);
    arr.append(0xa0);
    arr.append(0x8e);
    arr.append(0xed);
    arr.append(0xeb);
    arr.append(0x45);
    arr.append(0xfb);
    arr.append(0x63);
    arr.append(0x0f);
    arr.append(0x1c);
    arr.append(0xd9);
    arr.append(0x97);
    arr.append(0x36);
    arr.append(0xeb);
    arr.append(0x18);
    arr.append(0x57);
    arr.append(0x22);
    arr.append(0x17);
    arr.append(0xcb);
    arr.append(0xc6);
    arr.append(0xd5);
    arr.append(0xf3);
    arr.append(0x15);
    arr.append(0xb7);
    arr.append(0x1b);
    arr.append(0xe2);
    arr.append(0x03);
    arr.append(0xb0);
    arr.append(0x3c);
    arr.append(0xe8);
    arr.append(0xd9);
    arr.append(0x9b);
    arr.append(0x26);
    arr.append(0x14);
    arr.append(0xa0);
    arr.append(0x79);
    arr.append(0x23);
    arr.append(0xa3);
    arr.append(0x3d);
    arr.append(0xf6);
    arr.append(0x5a);
    arr.append(0x98);
    arr.append(0x6f);
    arr.append(0xd5);
    arr.append(0xe7);
    arr.append(0xf9);
    arr.append(0xe6);
    arr.append(0xe4);
    arr.append(0xc2);
    arr.append(0xb9);
    arr.append(0x69);
    arr.append(0x73);
    arr.append(0x6b);
    arr.append(0x08);
    arr.append(0x94);
    arr.append(0x4e);
    arr.append(0xbe);
    arr.append(0x99);
    arr.append(0x39);
    arr.append(0x4a);
    arr.append(0x86);
    arr.append(0x14);
    arr.append(0x61);
    arr.append(0x2f);
    arr.append(0xe6);
    arr.append(0x09);
    arr.append(0xf3);
    arr.append(0xa0);
    arr.append(0x65);
    arr.append(0x34);
    arr.append(0xd7);
    arr.append(0xd0);
    arr.append(0x1a);
    arr.append(0x20);
    arr.append(0x71);
    arr.append(0x4a);
    arr.append(0xa4);
    arr.append(0xfb);
    arr.append(0x2a);
    arr.append(0x55);
    arr.append(0xb9);
    arr.append(0x46);
    arr.append(0xce);
    arr.append(0x64);
    arr.append(0xc3);
    arr.append(0x22);
    arr.append(0x2d);
    arr.append(0xff);
    arr.append(0xad);
    arr.append(0x2a);
    arr.append(0xa2);
    arr.append(0xd1);
    arr.append(0x8a);
    arr.append(0x92);
    arr.append(0x34);
    arr.append(0x73);
    arr.append(0xc9);
    arr.append(0x2a);
    arr.append(0xb1);
    arr.append(0xfd);
    arr.append(0xa0);
    arr.append(0xbf);
    arr.append(0xf9);
    arr.append(0xc2);
    arr.append(0x8b);
    arr.append(0xfe);
    arr.append(0xb8);
    arr.append(0xbf);
    arr.append(0x2d);
    arr.append(0xa9);
    arr.append(0xb6);
    arr.append(0x18);
    arr.append(0xc8);
    arr.append(0xc3);
    arr.append(0xb0);
    arr.append(0x6f);
    arr.append(0xe8);
    arr.append(0x0c);
    arr.append(0xb1);
    arr.append(0xc0);
    arr.append(0xbd);
    arr.append(0x14);
    arr.append(0x47);
    arr.append(0x38);
    arr.append(0xf7);
    arr.append(0xc4);
    arr.append(0x21);
    arr.append(0x61);
    arr.append(0xff);
    arr.append(0x29);
    arr.append(0xe2);
    arr.append(0x50);
    arr.append(0x2f);
    arr.append(0xa0);
    arr.append(0x7f);
    arr.append(0x14);
    arr.append(0x61);
    arr.append(0x69);
    arr.append(0x3c);
    arr.append(0x70);
    arr.append(0x4e);
    arr.append(0xa5);
    arr.append(0x02);
    arr.append(0x1b);
    arr.append(0xbb);
    arr.append(0xa3);
    arr.append(0x5e);
    arr.append(0x72);
    arr.append(0xc5);
    arr.append(0x02);
    arr.append(0xf6);
    arr.append(0x43);
    arr.append(0x9e);
    arr.append(0x45);
    arr.append(0x8f);
    arr.append(0x98);
    arr.append(0x24);
    arr.append(0x2e);
    arr.append(0xd0);
    arr.append(0x37);
    arr.append(0x48);
    arr.append(0xea);
    arr.append(0x8f);
    arr.append(0xe2);
    arr.append(0xb3);
    arr.append(0x5f);
    arr.append(0x80);

    let (res, len) = rlp_decode(arr.span()).unwrap();
    assert(len == 1 + (0xf9-0xf7) + 0x0211, 'Wrong len');

    let mut expected: Array<Bytes> = ArrayTrait::new();

    let mut expected_0 = ArrayTrait::new();
    expected_0.append(0x77);
    expected_0.append(0x70);
    expected_0.append(0xcf);
    expected_0.append(0x09);
    expected_0.append(0xb5);
    expected_0.append(0x06);
    expected_0.append(0x7a);
    expected_0.append(0x1b);
    expected_0.append(0x35);
    expected_0.append(0xdf);
    expected_0.append(0x62);
    expected_0.append(0xa9);
    expected_0.append(0x24);
    expected_0.append(0x89);
    expected_0.append(0x81);
    expected_0.append(0x75);
    expected_0.append(0xce);
    expected_0.append(0xae);
    expected_0.append(0xec);
    expected_0.append(0xad);
    expected_0.append(0x1f);
    expected_0.append(0x68);
    expected_0.append(0xcd);
    expected_0.append(0xb4);
    expected_0.append(0xa8);
    expected_0.append(0x44);
    expected_0.append(0x40);
    expected_0.append(0x0c);
    expected_0.append(0x73);
    expected_0.append(0xc1);
    expected_0.append(0x4a);
    expected_0.append(0xf4);
    expected.append(expected_0.span());

    let mut expected_1 = ArrayTrait::new();
    expected_1.append(0x1e);
    expected_1.append(0xa3);
    expected_1.append(0x85);
    expected_1.append(0xd0);
    expected_1.append(0x5a);
    expected_1.append(0xb2);
    expected_1.append(0x61);
    expected_1.append(0x46);
    expected_1.append(0x6d);
    expected_1.append(0x5c);
    expected_1.append(0x04);
    expected_1.append(0x87);
    expected_1.append(0xfe);
    expected_1.append(0x68);
    expected_1.append(0x45);
    expected_1.append(0x34);
    expected_1.append(0xc1);
    expected_1.append(0x9f);
    expected_1.append(0x1a);
    expected_1.append(0x4b);
    expected_1.append(0x5c);
    expected_1.append(0x4b);
    expected_1.append(0x18);
    expected_1.append(0xdc);
    expected_1.append(0x1a);
    expected_1.append(0x36);
    expected_1.append(0x35);
    expected_1.append(0x60);
    expected_1.append(0x02);
    expected_1.append(0x50);
    expected_1.append(0x71);
    expected_1.append(0xb4);
    expected.append(expected_1.span());

    let mut expected_2 = ArrayTrait::new();
    expected_2.append(0x2c);
    expected_2.append(0x4c);
    expected_2.append(0x04);
    expected_2.append(0xce);
    expected_2.append(0x35);
    expected_2.append(0x40);
    expected_2.append(0xd3);
    expected_2.append(0xd1);
    expected_2.append(0x46);
    expected_2.append(0x18);
    expected_2.append(0x72);
    expected_2.append(0x30);
    expected_2.append(0x3c);
    expected_2.append(0x53);
    expected_2.append(0xa5);
    expected_2.append(0xe5);
    expected_2.append(0x66);
    expected_2.append(0x83);
    expected_2.append(0xc1);
    expected_2.append(0x30);
    expected_2.append(0x4f);
    expected_2.append(0x8d);
    expected_2.append(0x36);
    expected_2.append(0xa8);
    expected_2.append(0x80);
    expected_2.append(0x0c);
    expected_2.append(0x6a);
    expected_2.append(0xf5);
    expected_2.append(0xfa);
    expected_2.append(0x3f);
    expected_2.append(0xcd);
    expected_2.append(0xee);
    expected.append(expected_2.span());

    let mut expected_3 = ArrayTrait::new();
    expected_3.append(0xa9);
    expected_3.append(0xdc);
    expected_3.append(0x77);
    expected_3.append(0x8d);
    expected_3.append(0xc5);
    expected_3.append(0x4b);
    expected_3.append(0x7d);
    expected_3.append(0xd3);
    expected_3.append(0xc4);
    expected_3.append(0x82);
    expected_3.append(0x22);
    expected_3.append(0xe7);
    expected_3.append(0x39);
    expected_3.append(0xd1);
    expected_3.append(0x61);
    expected_3.append(0xfe);
    expected_3.append(0xb0);
    expected_3.append(0xc0);
    expected_3.append(0xee);
    expected_3.append(0xce);
    expected_3.append(0xb2);
    expected_3.append(0xdc);
    expected_3.append(0xd5);
    expected_3.append(0x17);
    expected_3.append(0x37);
    expected_3.append(0xf0);
    expected_3.append(0x5b);
    expected_3.append(0x8e);
    expected_3.append(0x37);
    expected_3.append(0xa6);
    expected_3.append(0x38);
    expected_3.append(0x51);
    expected.append(expected_3.span());

    let mut expected_4 = ArrayTrait::new();
    expected_4.append(0xa9);
    expected_4.append(0x5f);
    expected_4.append(0x4d);
    expected_4.append(0x55);
    expected_4.append(0x56);
    expected_4.append(0xdf);
    expected_4.append(0x62);
    expected_4.append(0xdd);
    expected_4.append(0xc2);
    expected_4.append(0x62);
    expected_4.append(0x99);
    expected_4.append(0x04);
    expected_4.append(0x97);
    expected_4.append(0xae);
    expected_4.append(0x56);
    expected_4.append(0x9b);
    expected_4.append(0xcd);
    expected_4.append(0x8e);
    expected_4.append(0xfd);
    expected_4.append(0xda);
    expected_4.append(0x7b);
    expected_4.append(0x20);
    expected_4.append(0x07);
    expected_4.append(0x93);
    expected_4.append(0xf8);
    expected_4.append(0xd3);
    expected_4.append(0xde);
    expected_4.append(0x4c);
    expected_4.append(0xdb);
    expected_4.append(0x97);
    expected_4.append(0x18);
    expected_4.append(0xd7);
    expected.append(expected_4.span());

    let mut expected_5 = ArrayTrait::new();
    expected_5.append(0x39);
    expected_5.append(0xd4);
    expected_5.append(0x06);
    expected_5.append(0x6d);
    expected_5.append(0x14);
    expected_5.append(0x38);
    expected_5.append(0x22);
    expected_5.append(0x6e);
    expected_5.append(0xaf);
    expected_5.append(0x4a);
    expected_5.append(0xc9);
    expected_5.append(0xe9);
    expected_5.append(0x43);
    expected_5.append(0xa8);
    expected_5.append(0x74);
    expected_5.append(0xa9);
    expected_5.append(0xa9);
    expected_5.append(0xc2);
    expected_5.append(0x5f);
    expected_5.append(0xb0);
    expected_5.append(0xd8);
    expected_5.append(0x1d);
    expected_5.append(0xb9);
    expected_5.append(0x86);
    expected_5.append(0x1d);
    expected_5.append(0x8c);
    expected_5.append(0x13);
    expected_5.append(0x36);
    expected_5.append(0xb3);
    expected_5.append(0xe2);
    expected_5.append(0x03);
    expected_5.append(0x4c);
    expected.append(expected_5.span());

    let mut expected_6 = ArrayTrait::new();
    expected_6.append(0x7a);
    expected_6.append(0xcc);
    expected_6.append(0x7c);
    expected_6.append(0x63);
    expected_6.append(0xb4);
    expected_6.append(0x6a);
    expected_6.append(0xa4);
    expected_6.append(0x18);
    expected_6.append(0xb3);
    expected_6.append(0xc9);
    expected_6.append(0xa0);
    expected_6.append(0x41);
    expected_6.append(0xa1);
    expected_6.append(0x25);
    expected_6.append(0x6b);
    expected_6.append(0xcb);
    expected_6.append(0x73);
    expected_6.append(0x61);
    expected_6.append(0x31);
    expected_6.append(0x6b);
    expected_6.append(0x39);
    expected_6.append(0x7a);
    expected_6.append(0xda);
    expected_6.append(0x5a);
    expected_6.append(0x88);
    expected_6.append(0x67);
    expected_6.append(0x49);
    expected_6.append(0x1b);
    expected_6.append(0xbb);
    expected_6.append(0x13);
    expected_6.append(0x01);
    expected_6.append(0x30);
    expected.append(expected_6.span());

    let mut expected_7 = ArrayTrait::new();
    expected_7.append(0x15);
    expected_7.append(0x35);
    expected_7.append(0x8a);
    expected_7.append(0x81);
    expected_7.append(0x25);
    expected_7.append(0x2e);
    expected_7.append(0xc4);
    expected_7.append(0x93);
    expected_7.append(0x71);
    expected_7.append(0x13);
    expected_7.append(0xfe);
    expected_7.append(0x36);
    expected_7.append(0xc7);
    expected_7.append(0x80);
    expected_7.append(0x46);
    expected_7.append(0xb7);
    expected_7.append(0x11);
    expected_7.append(0xfb);
    expected_7.append(0xa1);
    expected_7.append(0x97);
    expected_7.append(0x34);
    expected_7.append(0x91);
    expected_7.append(0xbb);
    expected_7.append(0x29);
    expected_7.append(0x18);
    expected_7.append(0x7a);
    expected_7.append(0x00);
    expected_7.append(0x78);
    expected_7.append(0x5f);
    expected_7.append(0xf8);
    expected_7.append(0x52);
    expected_7.append(0xae);
    expected.append(expected_7.span());

    let mut expected_8 = ArrayTrait::new();
    expected_8.append(0x68);
    expected_8.append(0x91);
    expected_8.append(0x42);
    expected_8.append(0xd3);
    expected_8.append(0x16);
    expected_8.append(0xab);
    expected_8.append(0xfa);
    expected_8.append(0xa7);
    expected_8.append(0x1c);
    expected_8.append(0x8b);
    expected_8.append(0xce);
    expected_8.append(0xdf);
    expected_8.append(0x49);
    expected_8.append(0x20);
    expected_8.append(0x1d);
    expected_8.append(0xdb);
    expected_8.append(0xb2);
    expected_8.append(0x10);
    expected_8.append(0x4e);
    expected_8.append(0x25);
    expected_8.append(0x0a);
    expected_8.append(0xdc);
    expected_8.append(0x90);
    expected_8.append(0xc4);
    expected_8.append(0xe8);
    expected_8.append(0x56);
    expected_8.append(0x22);
    expected_8.append(0x1f);
    expected_8.append(0x53);
    expected_8.append(0x4a);
    expected_8.append(0x96);
    expected_8.append(0x58);
    expected.append(expected_8.span());

    let mut expected_9 = ArrayTrait::new();
    expected_9.append(0xdc);
    expected_9.append(0x36);
    expected_9.append(0x50);
    expected_9.append(0x99);
    expected_9.append(0x25);
    expected_9.append(0x34);
    expected_9.append(0xfd);
    expected_9.append(0xa8);
    expected_9.append(0xa3);
    expected_9.append(0x14);
    expected_9.append(0xa7);
    expected_9.append(0xdb);
    expected_9.append(0xb0);
    expected_9.append(0xae);
    expected_9.append(0x3b);
    expected_9.append(0xa8);
    expected_9.append(0xc7);
    expected_9.append(0x9d);
    expected_9.append(0xb5);
    expected_9.append(0x55);
    expected_9.append(0x0c);
    expected_9.append(0x69);
    expected_9.append(0xce);
    expected_9.append(0x2a);
    expected_9.append(0x24);
    expected_9.append(0x60);
    expected_9.append(0xc0);
    expected_9.append(0x07);
    expected_9.append(0xad);
    expected_9.append(0xc4);
    expected_9.append(0xc1);
    expected_9.append(0xa3);
    expected.append(expected_9.span());

    let mut expected_10 = ArrayTrait::new();
    expected_10.append(0x20);
    expected_10.append(0xb0);
    expected_10.append(0x68);
    expected_10.append(0x3b);
    expected_10.append(0x66);
    expected_10.append(0x55);
    expected_10.append(0xb0);
    expected_10.append(0x05);
    expected_10.append(0x9e);
    expected_10.append(0xe1);
    expected_10.append(0x03);
    expected_10.append(0xd0);
    expected_10.append(0x4e);
    expected_10.append(0x4b);
    expected_10.append(0x50);
    expected_10.append(0x6b);
    expected_10.append(0xcb);
    expected_10.append(0xc1);
    expected_10.append(0x39);
    expected_10.append(0x00);
    expected_10.append(0x63);
    expected_10.append(0x92);
    expected_10.append(0xb7);
    expected_10.append(0xda);
    expected_10.append(0xb1);
    expected_10.append(0x11);
    expected_10.append(0x78);
    expected_10.append(0xc2);
    expected_10.append(0x66);
    expected_10.append(0x03);
    expected_10.append(0x42);
    expected_10.append(0xe7);
    expected.append(expected_10.span());

    let mut expected_11 = ArrayTrait::new();
    expected_11.append(0x8e);
    expected_11.append(0xed);
    expected_11.append(0xeb);
    expected_11.append(0x45);
    expected_11.append(0xfb);
    expected_11.append(0x63);
    expected_11.append(0x0f);
    expected_11.append(0x1c);
    expected_11.append(0xd9);
    expected_11.append(0x97);
    expected_11.append(0x36);
    expected_11.append(0xeb);
    expected_11.append(0x18);
    expected_11.append(0x57);
    expected_11.append(0x22);
    expected_11.append(0x17);
    expected_11.append(0xcb);
    expected_11.append(0xc6);
    expected_11.append(0xd5);
    expected_11.append(0xf3);
    expected_11.append(0x15);
    expected_11.append(0xb7);
    expected_11.append(0x1b);
    expected_11.append(0xe2);
    expected_11.append(0x03);
    expected_11.append(0xb0);
    expected_11.append(0x3c);
    expected_11.append(0xe8);
    expected_11.append(0xd9);
    expected_11.append(0x9b);
    expected_11.append(0x26);
    expected_11.append(0x14);
    expected.append(expected_11.span());

    let mut expected_12 = ArrayTrait::new();
    expected_12.append(0x79);
    expected_12.append(0x23);
    expected_12.append(0xa3);
    expected_12.append(0x3d);
    expected_12.append(0xf6);
    expected_12.append(0x5a);
    expected_12.append(0x98);
    expected_12.append(0x6f);
    expected_12.append(0xd5);
    expected_12.append(0xe7);
    expected_12.append(0xf9);
    expected_12.append(0xe6);
    expected_12.append(0xe4);
    expected_12.append(0xc2);
    expected_12.append(0xb9);
    expected_12.append(0x69);
    expected_12.append(0x73);
    expected_12.append(0x6b);
    expected_12.append(0x08);
    expected_12.append(0x94);
    expected_12.append(0x4e);
    expected_12.append(0xbe);
    expected_12.append(0x99);
    expected_12.append(0x39);
    expected_12.append(0x4a);
    expected_12.append(0x86);
    expected_12.append(0x14);
    expected_12.append(0x61);
    expected_12.append(0x2f);
    expected_12.append(0xe6);
    expected_12.append(0x09);
    expected_12.append(0xf3);
    expected.append(expected_12.span());

    let mut expected_13 = ArrayTrait::new();
    expected_13.append(0x65);
    expected_13.append(0x34);
    expected_13.append(0xd7);
    expected_13.append(0xd0);
    expected_13.append(0x1a);
    expected_13.append(0x20);
    expected_13.append(0x71);
    expected_13.append(0x4a);
    expected_13.append(0xa4);
    expected_13.append(0xfb);
    expected_13.append(0x2a);
    expected_13.append(0x55);
    expected_13.append(0xb9);
    expected_13.append(0x46);
    expected_13.append(0xce);
    expected_13.append(0x64);
    expected_13.append(0xc3);
    expected_13.append(0x22);
    expected_13.append(0x2d);
    expected_13.append(0xff);
    expected_13.append(0xad);
    expected_13.append(0x2a);
    expected_13.append(0xa2);
    expected_13.append(0xd1);
    expected_13.append(0x8a);
    expected_13.append(0x92);
    expected_13.append(0x34);
    expected_13.append(0x73);
    expected_13.append(0xc9);
    expected_13.append(0x2a);
    expected_13.append(0xb1);
    expected_13.append(0xfd);
    expected.append(expected_13.span());

    let mut expected_14 = ArrayTrait::new();
    expected_14.append(0xbf);
    expected_14.append(0xf9);
    expected_14.append(0xc2);
    expected_14.append(0x8b);
    expected_14.append(0xfe);
    expected_14.append(0xb8);
    expected_14.append(0xbf);
    expected_14.append(0x2d);
    expected_14.append(0xa9);
    expected_14.append(0xb6);
    expected_14.append(0x18);
    expected_14.append(0xc8);
    expected_14.append(0xc3);
    expected_14.append(0xb0);
    expected_14.append(0x6f);
    expected_14.append(0xe8);
    expected_14.append(0x0c);
    expected_14.append(0xb1);
    expected_14.append(0xc0);
    expected_14.append(0xbd);
    expected_14.append(0x14);
    expected_14.append(0x47);
    expected_14.append(0x38);
    expected_14.append(0xf7);
    expected_14.append(0xc4);
    expected_14.append(0x21);
    expected_14.append(0x61);
    expected_14.append(0xff);
    expected_14.append(0x29);
    expected_14.append(0xe2);
    expected_14.append(0x50);
    expected_14.append(0x2f);
    expected.append(expected_14.span());

    let mut expected_15 = ArrayTrait::new();
    expected_15.append(0x7f);
    expected_15.append(0x14);
    expected_15.append(0x61);
    expected_15.append(0x69);
    expected_15.append(0x3c);
    expected_15.append(0x70);
    expected_15.append(0x4e);
    expected_15.append(0xa5);
    expected_15.append(0x02);
    expected_15.append(0x1b);
    expected_15.append(0xbb);
    expected_15.append(0xa3);
    expected_15.append(0x5e);
    expected_15.append(0x72);
    expected_15.append(0xc5);
    expected_15.append(0x02);
    expected_15.append(0xf6);
    expected_15.append(0x43);
    expected_15.append(0x9e);
    expected_15.append(0x45);
    expected_15.append(0x8f);
    expected_15.append(0x98);
    expected_15.append(0x24);
    expected_15.append(0x2e);
    expected_15.append(0xd0);
    expected_15.append(0x37);
    expected_15.append(0x48);
    expected_15.append(0xea);
    expected_15.append(0x8f);
    expected_15.append(0xe2);
    expected_15.append(0xb3);
    expected_15.append(0x5f);
    expected.append(expected_15.span());

    let mut expected_16 = ArrayTrait::new();
    expected.append(expected_16.span());
    let expected_item = RLPItem::List(expected.span());

    assert(res == expected_item, 'Wrong value');
}
