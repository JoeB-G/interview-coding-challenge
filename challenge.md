Background Information
In the UK, a vehicle needs to be registered to be used on roads. This is known as the vehicle’s registration number. There are various rules that are applied to create unique registration numbers.

You have been given a dataset containing vehicles that are yet to be registered.

Note: These rules are fictional and were created for the purpose of this exercise.


Vehicle Registration Number: 
  
Area Code 	 	Age Identifier 	 	Random Letters
L 	L 	 	D 	D 	 	L 	L 	L
Letter 	Letter 	Whitespace 	Digit 	Digit 	Whitespace 	Letter 	Letter 	Letter

Example registration number: CA 12 ABC


Area Code:

The area code is determined from a vehicle’s registration area. The following rules are used to determine the area code.

Registration Area 	First letter 	Second letter 	Example
Swansea 	C 	A ... K 	CB
Cardiff 	C 	L ... Z 	CM
Birmingham 	B 	A B C 	BB


Age Identifier:

The age identifier is determined from a vehicle’s date of manufacture.

Date range 	Rule 	Example
March - Aug 	Year without century 	01-05-2024 = 24
Sep - Feb  	Year without century + 50 	01-09-2024 = 74


Random Letters:

The following letters cannot appear: [ I, K, M, Y ]

Examples:

Valid: [ ABC, FGH, … ]
Invalid: [ ABI, YDF, … ]


Presentation Scenario 
  
You will need to author code which performs the following functions:

1.	For each vehicle in the dataset, generate a valid Vehicle Registration Number using the rules defined above.  
 
2.	Output the following information:
                                                                                                                       a.	Total number of registration numbers generated.
                                                                                                                       b.	Total number of registration numbers generated per registration area.

3.	Were there any vehicles where the Vehicle Registration Number could not be determined? If so, how many?

You may use any reasonable general-purpose programming language to implement your solution. (Your audience will be unlikely to understand deliberately esoteric and obfuscatory toy languages, e.g., Malbolge.) 
  
The code is expected to compile and run successfully. You may use third-party libraries to assist you, but the implementation of task must be original. 
  
You do not have to implement testing for this code, but you should consider how you might test it since you may be asked about it. 
  
You must submit your solution at least 24 hours before your interview. Please provide a link to a public source code repository such as GitHub to ITSRecruitment@dvla.gov.uk


The Presentation Task  
  
You should prepare a short (10 minutes) presentation in advance. You will be asked to present this during the interview.

Your presentation should cover:
- A working demo of your code against the two criteria
- A general overview of how your code works
- Aspects of the task you enjoyed or disliked
- Aspects of the task you found difficult and why
- Aspects of your code you would improve or change if you refactored it or did the task again

Your presentation should not cover:
- A line-by-line explanation of the code 
