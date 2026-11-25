import React from 'react';
import heroBg from '../assets/hero1.jpg';

export default function Hero() {
  return (
    <section className="relative w-full min-h-[520px] md:min-h-[600px] flex items-center overflow-hidden">
      {/* Background Foto Sawah Terasering */}
      <div
        className="absolute inset-0 bg-cover bg-center bg-no-repeat"
        style={{
          backgroundImage: `url(${heroBg})`,
        }}
      />

      {/* Overlay gelap tipis di sisi kiri supaya teks putih tetap kontras dan terbaca */}
      <div className="absolute inset-0 bg-gradient-to-r from-black/65 via-black/35 to-transparent" />

      {/* Konten Utama */}
      <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full py-16">
        <div className="max-w-xl">
          <h1 className="text-4xl sm:text-5xl md:text-[54px] font-bold text-white leading-[1.15] tracking-tight">
            Pemberdayaan <br />
            UMKM Warga <br />
            Desa Indonesia
          </h1>

          <p className="mt-5 text-base sm:text-lg text-white/95 font-normal leading-relaxed">
            Jelajahi beragam produk unggulan lokal langsung dari UMKM masyarakat desa.
          </p>

          {/* Tombol Aksi */}
          <div className="mt-8 flex flex-wrap items-center gap-4">
            <button
              type="button"
              className="px-7 py-3 text-sm font-semibold text-white bg-[#13469E] hover:bg-[#0F3880] rounded-xl shadow-md transition cursor-pointer"
            >
              Jelajahi
            </button>

            <button
              type="button"
              className="px-8 py-3 text-sm font-semibold text-[#13469E] bg-white hover:bg-slate-100 rounded-xl shadow-md transition cursor-pointer"
            >
              Daftar Jadi Mitra UMKM
            </button>
          </div>
        </div>
      </div>
    </section>
  );
}