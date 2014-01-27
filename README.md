pycam2marlin
============

![just a image](https://raw.github.com/talpadk/pycam2marlin/master/images/gcode.jpg)

A script to convert the compact G-code written by PyCAM into a less compact version that the Marlin firmware understands.

**PyCAM** is a python based CAM package that can create different milling tool paths.

**Marlin** is a firmware that is used on many 3D printer controller boards which can be used as a stand alone milling controller.

### Known features

* Hardcoded feedrates for G0 uncoordinated "rapid" moves, the actual feed rate should be limited by your marlin configuration
* The planed reduced plunge rate enhancement of the pycam output is yet to be implemented.

### Usage 
Just send the script the input code on standard in, the script writes to standard out, eg.:

    pycam2marlin.pl <input_file >output_file

### Checking the output
I still consider it a good idea to manually check the output generated by the script.

Especially checking which lines have been discarded, something like:

    grep -i Discarded output_file

or 

    grep '!' output_file

might be a good start, specifically look for discarded moves.