# config.py
import mysql.connector

# Fungsi koneksi (dibuat dalam fungsi agar stabil saat reload)
def get_connection():
    return mysql.connector.connect(
        host="localhost",
        port="3306",
        user="root",
        password="",      # Isi password jika ada
        database="student_score"
    )

def view_students():
    conn = get_connection()
    c = conn.cursor()
    # Mengambil semua data siswa
    c.execute('SELECT * FROM students ORDER BY full_name ASC')
    data = c.fetchall()
    conn.close()
    return data

def view_subjects():
    conn = get_connection()
    c = conn.cursor()
    c.execute('SELECT * FROM subjects ORDER BY subject_name ASC')
    data = c.fetchall()
    conn.close()
    return data

def view_majors():
    conn = get_connection()
    c = conn.cursor()
    c.execute('SELECT * FROM majors ORDER BY major_name ASC')
    data = c.fetchall()
    conn.close()
    return data

def view_exam_results_by_student():
    conn = get_connection()
    c = conn.cursor()
    # PERBAIKAN: Menggunakan id_result, id_student, id_subject
    query = '''
        SELECT
            er.id_result,
            s.full_name,
            sub.subject_name,
            er.score
        FROM
            exam_results er
        JOIN
            students s ON er.id_student = s.id_student
        JOIN
            subjects sub ON er.id_subject = sub.id_subject
        ORDER BY
            s.full_name ASC, sub.subject_name ASC
    '''
    c.execute(query)
    data = c.fetchall()
    conn.close()
    return data

def view_career_recommendations():
    conn = get_connection()
    c = conn.cursor()
    # PERBAIKAN: Menggunakan id_recommendation dan id_student
    query = '''
        SELECT
            cr.id_recommendation,
            s.full_name,
            cr.strongest_subject,
            cr.highest_score,
            cr.recommended_career,
            cr.career_field
        FROM
            career_recommendation cr
        JOIN
            students s ON cr.id_student = s.id_student
        ORDER BY
            s.full_name ASC
    '''
    c.execute(query)
    data = c.fetchall()
    conn.close()
    return data