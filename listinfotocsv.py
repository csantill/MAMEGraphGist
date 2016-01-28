# -*- coding: utf-8 -*-
"""
Created on Mon Jan 25 13:06:17 2016

@author: Carlos.Santillan
"""

import os
from sys import argv
import csv
import re
import xml.etree.ElementTree as ET
from StringIO import StringIO



def parsexml(filename):
    tree = ET.parse(filename)
    csvfile = open(r'.\mamelist.csv','wb')
    writer = csv.writer(csvfile,delimiter=',')
    name='name'
    sourcefile='sourcefile'
    cloneof='cloneof'
    year='year'
    manufacturer = 'manufacturer'
    description = 'description'
    status='status'

    writer.writerow((name,sourcefile,cloneof,year,manufacturer,description,status))

    root = tree.getroot()
    #mame =root.find('mame')
    for machines in root.iter('machine'):
        name= machines.get('name')
        cloneof = machines.get('cloneof',default='')
        sourcefile= machines.get('sourcefile')
        yearelement = machines.find('year')
        if yearelement is None:
            continue
        description=machines.find('description').text.encode('utf-8').strip()
        year = yearelement.text
        manufacturer = machines.find('manufacturer').text
        driver = machines.find('driver')
        status = driver.get('status')
        writer.writerow((name,sourcefile,cloneof,year,manufacturer,description,status))

parsexml(r'.\mamelist.xml')
