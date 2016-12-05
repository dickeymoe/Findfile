# Findfile
Script used to copy files recursively based on their file extensions. Also gives the ability to prepend the filenames for the files copied.


# Usage
Findfile.cmd SOURCE_DIR FILENAMES [[-h | --help | /? ]]  
| [[-c | -copy] [CopyLocation]] [[-p | -prepend] PrependString]

THIS WILL DISPLAY .TXT FILES FROM C:\FOLDER IN THE CONSOLE

      findfile C:\Folder *.txt

                   -or-

      findfile C:\Folder filename.txt

THIS WILL COPY RECURSIVELY .TXT FILES FROM C:\FOLDER TO 
SPECIFIED LOCATION BASED ON FILE EXTENSION

      findfile C:\Folder *.txt -c C:\CopiedTextFiles

					-or-

      findfile C:\Folder *.txt -c .\CopiedTextFiles

THIS WILL PREPEND .TXT FILES FROM C:\FOLDER WITH "PRE_"

      findfile C:\Folder *.txt -c C:\CopiedTextFiles -p pre_

					-or-

      findfile . *.txt -c .\CopiedTextFiles -p pre_

           SAMPLE OUTPUT: pre_thisfile.txt
