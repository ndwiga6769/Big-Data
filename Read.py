
example1 = "C:\\Users\Administrator\Desktop\Main\Big-Data\example1.txt"


with open(example1, "a+") as readfile:
    readfile.write("This is line Mercy.\n This is line Mugweru.")
    print(readfile.read())