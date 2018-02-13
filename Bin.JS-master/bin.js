/* 
 * The MIT License
 *
 * Copyright 2017 Krzysztof Szewczyk
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */



/**
 * Main Namespace
 * @type object
 */
var binjs = binjs || {};

/**
 * File 'class' for binjs namespace.
 * Contains all of library code.
 */

/**
 * Creates new file object with specified
 * name. Remember that parameter 'name'
 * is critical. You cannot create File
 * instance without providing it's name.
 * 
 * @param {string} name
 * @returns {BinJSFile}
 */

binjs.File = function (name) {
    if (name === undefined) {
        throw "[bin.js] Filename must be provided.";
    } else {
        /**
         * Filename
         */
        this.name = name;

        /**
         * File Buffer
         */
        this.buffer = [];

        /**
         * Variable that holds invaildation status
         * (after closing invaildate changes to true)
         * 
         * If invaildate is set to true, you cannot 
         * perform any action on file. Everything
         * you can do then is just set object to undefined.
         */
        this.invaildate = false;

        /**
         * Closes file, by removing name
         * and buffer properties of File
         * class.
         * 
         * Invaildates it, so you cant use
         * any function on file object
         * after calling this method.
         * 
         * Please look at 'invaildate'
         * field description.
         */
        this.close = function () {
            if (!this.invaildate) {
                delete this.buffer;
                delete this.name;
                this.invaildate = true;
            } else
                throw "[bin.js] File alreday closed.";
        };

        /**
         * Sets file buffer to passed variable.
         * It's expected to be string.
         * If not, error will be thrown.
         * 
         * @param {string} txt
         */
        this.setText = function (txt) {
            if (this.invaildate) {
                throw "[bin.js] File alreday closed.";
            } else if (typeof (txt) === 'string')
                buffer = txt.split('');
            else
                throw "[bin.js] You can set buffer only to string variable.";
        };

        /**
         * Returns text that curerntly is in buffer.
         * Throws an exception if file was
         * closed before.
         * 
         * @returns {string}
         */
        this.getText = function () {
            if (this.invaildate) {
                throw "[bin.js] File alreday closed.";
            } else
                return this.buffer.join('');
        };

        /**
         * This function adds character to file buffer.
         * Be care what you pass to it. It's faster
         * than:
         * <pre><code>
         * 
         * var f = new binjs.File('dummy.js');
         * 
         *  // ...
         * 
         * f.setText(f.getText() + text);
         * 
         * </code></pre>
         * 
         * Uses buffer.push().
         * 
         * Throws an error if file was
         * closed before.
         * 
         * @param {any except undefined and array} c
         */
        this.put = function (c) {
            if (typeof (c) === 'undefined')
                throw "[bin.js] You must pass at least one argument.";
            if (this.invaildate) {
                throw "[bin.js] File alreday closed.";
            } else
                this.buffer.push(c);
        };

        /**
         * Starts downloading process.
         * Characters here are escaped using
         * encodeURI function. It creates
         * invisible '<A>' element in document
         * body and forces download file 
         * dialog. Should work with all
         * HTML5-ready browsers. Shouldn't
         * break website layout.
         * 
         * I'm unsure about older browsers
         * (I am looking on you, damn IE9).
         * 
         * Throws error if buffer was closed
         * before function call
         * 
         * @returns nothing
         */

        this.download = function () {
            if (this.invaildate) {
                throw "[bin.js] File alreday closed.";
            } else {
                var element = document.createElement('a');
                element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURI(this.buffer.join('')));
                element.setAttribute('download', this.name);
                element.style.display = 'none';
                document.body.appendChild(element);
                element.click();
                document.body.removeChild(element);
            }
        };

        /**
         * Returns hash code of buffer.
         * Name of file doesn't affect
         * hash code. File with any name
         * and same content must return
         * the same value of this hashing
         * function.
         * 
         * Throws an exception if buffer
         * was closed before function call.
         * 
         * @returns {Number}
         */

        this.hashCode = function() {

            if (this.invaildate) {
                throw "[bin.js] File alreday closed.";
            }

            /**
             * Simple implementation of simple
             * Java's algorithm - String.hashCode().
             * @param {type} str
             * @returns {Number}
             */

            var hashcode = function (str) {
                var hash = 0;
                if (str.length === 0)
                    return hash;
                else
                    for (i = 0; i < str.length; i++) {
                        char = str.charCodeAt(i);
                        hash = ((hash << 5) - hash) + char;
                        hash = hash & hash;
                    }
                return hash;
            }(this.buffer);

            return hashcode;
        };
    }
};

