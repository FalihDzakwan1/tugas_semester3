import streamlit as st
import pandas as pd
import config  # Memanggil file config.py

# --- 1. KONFIGURASI HALAMAN ---
st.set_page_config(page_title="Dashboard Akademik", layout="wide")

# --- 2. FUNGSI LOAD DATA ---
def get_data_mahasiswa():
    data = config.view_students()
    if not data: return pd.DataFrame()
    # Sesuaikan kolom dengan database
    df = pd.DataFrame(data, columns=['ID', 'ID Major', 'Nama', 'Email', 'No HP', 'Gender', 'Tgl Lahir', 'Alamat', 'Ortu', 'HP Ortu'])
    return df

def get_data_nilai():
    data = config.view_exam_results_by_student()
    if not data: return pd.DataFrame()
    df = pd.DataFrame(data, columns=['ID Result', 'Nama Siswa', 'Mata Pelajaran', 'Nilai'])
    return df

def get_data_karir():
    data = config.view_career_recommendations()
    if not data: return pd.DataFrame()
    df = pd.DataFrame(data, columns=['ID', 'Nama Siswa', 'Mapel Terkuat', 'Nilai Tertinggi', 'Rekomendasi Karir', 'Bidang'])
    return df

def get_data_jurusan():
    data = config.view_majors()
    if not data: return pd.DataFrame()
    df = pd.DataFrame(data, columns=['ID Major', 'Nama Jurusan'])
    return df

# --- 3. SIDEBAR (NAVIGASI) ---
st.sidebar.header("Navigasi")
menu = st.sidebar.radio(
    "Pilih Halaman:", 
    ["Dashboard", "Data Mahasiswa", "Data Nilai", "Rekomendasi Karir", "Data Jurusan"]
)

st.sidebar.markdown("---")

# --- 4. ISI HALAMAN ---

# === HALAMAN 1: DASHBOARD UTAMA ===
if menu == "Dashboard":
    st.title("🎓 Dashboard Akademik")
    st.write("Ringkasan data performa mahasiswa.")
    
    df_mhs = get_data_mahasiswa()
    df_nilai = get_data_nilai()
    
    # Metrics
    col1, col2, col3 = st.columns(3)
    with col1:
        st.metric("Total Mahasiswa", f"{len(df_mhs)} Orang")
    with col2:
        rata_nilai = df_nilai['Nilai'].mean() if not df_nilai.empty else 0
        st.metric("Rata-rata Nilai", f"{rata_nilai:.2f}")
    with col3:
        jumlah_mapel = df_nilai['Mata Pelajaran'].nunique() if not df_nilai.empty else 0
        st.metric("Jumlah Mata Pelajaran", f"{jumlah_mapel}")
        
    st.divider()
    
    # Grafik
    st.subheader("Grafik Rata-rata Nilai per Mata Pelajaran")
    if not df_nilai.empty:
        rata_per_mapel = df_nilai.groupby("Mata Pelajaran")["Nilai"].mean()
        st.bar_chart(rata_per_mapel)
    else:
        st.warning("Data nilai belum tersedia.")

# === HALAMAN 2: DATA MAHASISWA ===
elif menu == "Data Mahasiswa":
    st.title("📂 Data Mahasiswa")
    
    # Load Data Siswa & Jurusan
    df_mhs = get_data_mahasiswa()
    df_jurusan = get_data_jurusan()
    
    # Gabungkan (Merge) agar kita bisa filter berdasarkan Nama Jurusan, bukan cuma ID
    if not df_mhs.empty and not df_jurusan.empty:
        # Join tabel siswa dengan tabel jurusan berdasarkan 'ID Major'
        df_display = pd.merge(df_mhs, df_jurusan, on='ID Major', how='left')
        
        # Pindahkan kolom Nama Jurusan ke posisi yang lebih enak dilihat (opsional)
        cols = ['ID', 'Nama', 'Nama Jurusan', 'Email', 'No HP', 'Gender', 'Alamat']
        # Filter kolom yang ada saja
        df_display = df_display[cols]
    else:
        df_display = df_mhs

    # --- Bagian Filter ---
    col1, col2 = st.columns(2)
    
    with col1:
        cari_nama = st.text_input("Cari Nama Mahasiswa:")
        
    with col2:
        # Ambil daftar unik jurusan dari data
        if 'Nama Jurusan' in df_display.columns:
            list_jurusan = ["Semua"] + list(df_display['Nama Jurusan'].unique())
            pilih_jurusan = st.selectbox("Filter Jurusan:", list_jurusan)
        else:
            pilih_jurusan = "Semua"

    # --- Logika Filter ---
    if not df_display.empty:
        if pilih_jurusan != "Semua":
            df_display = df_display[df_display['Nama Jurusan'] == pilih_jurusan]
        
        if cari_nama:
            df_display = df_display[df_display['Nama'].str.contains(cari_nama, case=False)]
            
        st.info(f"Menampilkan {len(df_display)} data.")
        st.dataframe(df_display, use_container_width=True)
    else:
        st.warning("Data mahasiswa kosong.")

# === HALAMAN 3: DATA NILAI ===
elif menu == "Data Nilai":
    st.title("📝 Data Nilai Ujian")
    df = get_data_nilai()
    
    if not df.empty:
        # Filter Mata Pelajaran
        list_mapel = ["Semua"] + list(df['Mata Pelajaran'].unique())
        pilih_mapel = st.selectbox("Filter Mata Pelajaran:", list_mapel)
        
        if pilih_mapel != "Semua":
            df = df[df['Mata Pelajaran'] == pilih_mapel]
            
        st.dataframe(df, use_container_width=True)
    else:
        st.warning("Data nilai kosong.")

# === HALAMAN 4: REKOMENDASI KARIR ===
elif menu == "Rekomendasi Karir":
    st.title("🚀 Rekomendasi Karir")
    df = get_data_karir()
    
    if not df.empty:
        # Filter Bidang Karir
        list_bidang = ["Semua"] + list(df['Bidang'].unique())
        pilih_bidang = st.selectbox("Filter Bidang Karir:", list_bidang)
        
        if pilih_bidang != "Semua":
            df = df[df['Bidang'] == pilih_bidang]
            
        st.dataframe(df, use_container_width=True)
    else:
        st.warning("Data rekomendasi karir kosong.")

# === HALAMAN 5: DATA JURUSAN ===
elif menu == "Data Jurusan":
    st.title("🏫 Data Jurusan")
    df = get_data_jurusan()
    
    if not df.empty:
        st.dataframe(df, use_container_width=True)
    else:
        st.warning("Data jurusan kosong.")