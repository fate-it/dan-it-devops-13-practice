from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)
FILE = 'students.csv'
FIELDS = ['id', 'first_name', 'last_name', 'age']


def read_students():
    if not os.path.exists(FILE):
        return []

    with open(FILE, newline='', encoding='utf-8') as f:
        return list(csv.DictReader(f))


def write_students(students):
    with open(FILE, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(students)


def get_next_id(students):
    if not students:
        return 1
    return max(int(s['id']) for s in students) + 1


@app.route('/students', methods=['GET'])
def get_all():
    return jsonify(read_students())


@app.route('/students/id/<int:student_id>', methods=['GET'])
def get_by_id(student_id):
    students = read_students()
    for s in students:
        if int(s['id']) == student_id:
            return jsonify(s)
    return jsonify({'error': 'Student not found'}), 404


@app.route('/students/lastname/<last_name>', methods=['GET'])
def get_by_lastname(last_name):
    students = read_students()
    result = [s for s in students if s['last_name'] == last_name]

    if not result:
        return jsonify({'error': 'Student not found'}), 404

    return jsonify(result)


@app.route('/students', methods=['POST'])
def create_student():
    data = request.json

    if not data:
        return jsonify({'error': 'Empty body'}), 400

    if set(data.keys()) != {'first_name', 'last_name', 'age'}:
        return jsonify({'error': 'Invalid fields'}), 400

    students = read_students()
    new_student = {
        'id': str(get_next_id(students)),
        'first_name': data['first_name'],
        'last_name': data['last_name'],
        'age': str(data['age'])
    }

    students.append(new_student)
    write_students(students)

    return jsonify(new_student), 201


@app.route('/students/<int:student_id>', methods=['PUT'])
def update_student(student_id):
    data = request.json

    if not data:
        return jsonify({'error': 'Empty body'}), 400

    if set(data.keys()) != {'first_name', 'last_name', 'age'}:
        return jsonify({'error': 'Invalid fields'}), 400

    students = read_students()

    for s in students:
        if int(s['id']) == student_id:
            s['first_name'] = data['first_name']
            s['last_name'] = data['last_name']
            s['age'] = str(data['age'])
            write_students(students)
            return jsonify(s)

    return jsonify({'error': 'Student not found'}), 404


@app.route('/students/<int:student_id>', methods=['PATCH'])
def update_age(student_id):
    data = request.json

    if not data or set(data.keys()) != {'age'}:
        return jsonify({'error': 'Invalid fields'}), 400

    students = read_students()

    for s in students:
        if int(s['id']) == student_id:
            s['age'] = str(data['age'])
            write_students(students)
            return jsonify(s)

    return jsonify({'error': 'Student not found'}), 404


@app.route('/students/<int:student_id>', methods=['DELETE'])
def delete_student(student_id):
    students = read_students()

    for s in students:
        if int(s['id']) == student_id:
            students.remove(s)
            write_students(students)
            return jsonify({'message': 'Deleted successfully'})

    return jsonify({'error': 'Student not found'}), 404


if __name__ == '__main__':
    app.run(debug=True)