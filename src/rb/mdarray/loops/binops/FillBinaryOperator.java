/*****************************************************************************************
 * @author Rodrigo Botafogo
 *
 * Copyright © 2013 Rodrigo Botafogo. All Rights Reserved. Permission to use, copy, 
 * modify, and distribute this software and its documentation, without fee and without a 
 * signed licensing agreement, is hereby granted, provided that the above copyright notice, 
 * this paragraph and the following two paragraphs appear in all copies, modifications, and 
 * distributions.
 *
 * IN NO EVENT SHALL RODRIGO BOTAFOGO BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, 
 * INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF 
 * THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF RODRIGO BOTAFOGO HAS BEEN ADVISED OF THE 
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * RODRIGO BOTAFOGO SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE 
 * SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS". 
 * RODRIGO BOTAFOGO HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, 
 * ENHANCEMENTS, OR MODIFICATIONS.
 *****************************************************************************************/

package rb.mdarray.loops.binops;

import ucar.ma2.*;

public class FillBinaryOperator {

    public static void apply(ArrayByte array, byte val) {
	IndexIterator iterator = array.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setByteNext(val);
	}
    }

    public static void apply(ArrayByte array, Array op2) {
	IndexIterator iterator = array.getIndexIterator();
	IndexIterator iteratorOp2 = op2.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setByteNext(iteratorOp2.getByteNext());
	}
    }


    public static void apply(ArrayShort array, short val) {
	IndexIterator iterator = array.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setShortNext(val);
	}
    }

    public static void apply(ArrayShort array, Array op2) {
	IndexIterator iterator = array.getIndexIterator();
	IndexIterator iteratorOp2 = op2.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setShortNext(iteratorOp2.getShortNext());
	}
    }

    public static void apply(ArrayInt array, int val) {
	IndexIterator iterator = array.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setIntNext(val);
	}
    }

    public static void apply(ArrayInt array, Array op2) {
	IndexIterator iterator = array.getIndexIterator();
	IndexIterator iteratorOp2 = op2.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setIntNext(iteratorOp2.getIntNext());
	}
    }

    public static void apply(ArrayLong array,  long val) {
	IndexIterator iterator = array.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setLongNext(val);
	}
    }

    public static void apply(ArrayLong array, Array op2) {
	IndexIterator iterator = array.getIndexIterator();
	IndexIterator iteratorOp2 = op2.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setLongNext(iteratorOp2.getLongNext());
	}
    }


    public static void apply(ArrayFloat array, float val) {
	IndexIterator iterator = array.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setFloatNext(val);
	}
    }

    public static void apply(ArrayFloat array, Array op2) {
	IndexIterator iterator = array.getIndexIterator();
	IndexIterator iteratorOp2 = op2.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setFloatNext(iteratorOp2.getFloatNext());
	}
    }

    public static void apply(ArrayDouble array, double val) {
	IndexIterator iterator = array.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setDoubleNext(val);
	}
    }

    public static void apply(ArrayDouble array, Array op2) {
	IndexIterator iterator = array.getIndexIterator();
	IndexIterator iteratorOp2 = op2.getIndexIterator();
	for (long i = array.getSize(); --i >= 0; ) {
	    iterator.setDoubleNext(iteratorOp2.getDoubleNext());
	}
    }

}