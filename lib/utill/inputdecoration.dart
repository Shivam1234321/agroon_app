
import 'package:flutter/material.dart';

import 'color_resources.dart';


InputDecoration buildInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    hintStyle: const TextStyle(
        color: ColorResources.black,
        fontFamily: "Roboto",
        fontSize: 13),

    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
    errorStyle: const TextStyle(height: 0),
    // prefixIcon: Icon(icons),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(26.0)),
      borderSide: BorderSide(color: ColorResources.light_purple),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(26.0),
      borderSide: const BorderSide(color: ColorResources.light_purple, width: 1),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(26.0)),
      borderSide: BorderSide(color: ColorResources.light_purple, width: 1),
    ),
  );
}

InputDecoration buildPriceInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    hintStyle: const TextStyle(
        color: ColorResources.black,
        fontFamily: "Roboto",
        fontSize: 13),
    prefixText: "₹",
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
    errorStyle: const TextStyle(height: 0),
    // prefixIcon: Icon(icons),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(26.0)),
      borderSide: BorderSide(color: ColorResources.light_purple),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(26.0),
      borderSide: const BorderSide(color: ColorResources.light_purple, width: 1),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(26.0)),
      borderSide: BorderSide(color: ColorResources.light_purple, width: 1),
    ),
  );
}