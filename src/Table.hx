// -*- mode:java; tab-width:4; c-basic-offset:4; indent-tabs-mode:nil -*-

interface Table {
    var height(getHeight,never) : Int; // Read-only height property
    var width(getWidth,never) : Int; // Read-only width property
    function getCell(x: Int, y: Int) : Datum;
    function setCell(x: Int, y: Int, c : Datum) : Void;
    function getCellView() : View;
}
