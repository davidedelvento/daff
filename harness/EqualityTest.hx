// -*- mode:java; tab-width:4; c-basic-offset:4; indent-tabs-mode:nil -*-

package harness;

class EqualityTest extends haxe.unit.TestCase {
    var data1 : Array<Array<Dynamic>>;
    var data2 : Array<Array<Dynamic>>;
    var data3 : Array<Array<Dynamic>>;
    var data4 : Array<Array<Dynamic>>;
    var fp_data : Array<Array<Dynamic>>;
    var fp_data_1pc : Array<Array<Dynamic>>;
    var fp_data_exp : Array<Array<Dynamic>>;
    var fp_data_edge1 : Array<Array<Dynamic>>;
    var fp_data_edge2 : Array<Array<Dynamic>>;

    override public function setup() {
        data1 = [['Country','Capital'],
                 ['  Ireland','Dublin'],
                 ['France',15],
                 ['Spain','     Barcelona']];
        data2 = [['Country','Capital'],
                 ['Ireland','  Dublin'],
                 ['France',15],
                 ['Spain','  Barcelona  ']];
        data3 = [['Country','Capital'],
                 ['Ireland','  Dublin'],
                 ['France',15],
                 ['Spain','  Madrid  ']];
        data4 = [['COUNTRY','Capital'],
                 ['IRELAND','DUBlin'],
                 ['France',15],
                 ['SPAIN','BARCELONA']];
        fp_data =     [['Time',    'Steps','Avg',   'Speed',   'I/O time'],
                       ['82.456',  '149',  '0.553', '130.106', '18.391']];
        fp_data_1pc = [['Time',    'Steps','Avg',   'Speed',   'I/O time'],
                       ['82.282',  '149',  '0.553', '130.2',   '18.317']];
        fp_data_exp = [['Time',    'Steps','Avg',   'Speed',   'I/O time'],
                       ['8.245600e+01',  '149',  '5.530000e-01', '1.301060e+02', '1.839100e+01']];
        fp_data_edge1 = [['Time',    'Steps','Avg',   'Speed',   'I/O time'],
                         ['0.0',     '0',    '2.00',  '130.106', '18.39']];
        fp_data_edge2 = [['Time',    'Steps','Avg',   'Speed',   'I/O time'],
                         ['0.0',     '0',    '2.01',  '131.106', '18.31']];
    }

    public function testFloatingPoints_edge_cases(){
        var table1 = Native.table(fp_data_edge1);
        var table2 = Native.table(fp_data_edge2);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(2,o.height);
        flags.fp_threshold = 0.0;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(2,o.height);
        flags.fp_threshold = 0.01;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(1,o.height);
    }

    public function testFloatingPoints_exp(){
        var table1 = Native.table(fp_data);
        var table2 = Native.table(fp_data_exp);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(2,o.height);
        flags.fp_threshold = 0.0;
        o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(1,o.height);
    }

    public function testFloatingPoints_1pc(){
        var table1 = Native.table(fp_data);
        var table2 = Native.table(fp_data_1pc);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(2,o.height);
        flags.fp_threshold = 0.01;
        o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(1,o.height);
        flags.fp_threshold = 0.0001;
        o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(2,o.height);
    }

    public function testWhiteSpace(){
        var table1 = Native.table(data1);
        var table2 = Native.table(data2);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(4,o.height);
        flags.ignore_whitespace = true;
        o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(1,o.height);
        var table3 = Native.table(data3);
        o = coopy.Coopy.diff(table1,table3,flags);
        assertEquals(2,o.height);
    }

    public function testCase(){
        var table1 = Native.table(data1);
        var table4 = Native.table(data4);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table4,flags);
        assertEquals(6,o.height);
        flags.ignore_case = true;
        flags.ignore_whitespace = true;
        o = coopy.Coopy.diff(table1,table4,flags);
        assertEquals(1,o.height);
    }
}
