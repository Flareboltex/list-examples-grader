CPATH=.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then 
    echo "ListExamples.java file found."
else
    echo "ListExamples.java file not found."
    echo "Your score: 0.0%"
    exit
fi

cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java 

if [[ $? -eq 0 ]]
then
    echo "Your code compiled succesfully!"
else
    echo "Your code failed to compile!"
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > results.txt

output_file="results.txt"
if grep -q "OK" "$output_file"; then
    echo "Your score: 100.0%"
else
    failure_line=$(grep -i "Failures:" results.txt)
    test_count=$(echo "$failure_line" | cut -d ' ' -f3 | cut -d ',' -f1)
    failure_count=$(echo "$failure_line" | cut -d ' ' -f6)
    success_count=$(( $test_count - $failure_count ))

    result=$(( ($success_count * 1000) / $test_count ))
    echo $failure_line
    integer_part=$(( $result / 10 ))
    decimal_part=$(( $result % 10 ))

    percentage="$integer_part.$decimal_part"
    echo "Your score: $percentage%"
fi






# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
