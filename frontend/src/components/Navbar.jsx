import React, { useState } from 'react';

export default function Navbar() {
  const [searchQuery, setSearchQuery] = useState('');

  const handleSearch = (e) => {
    e.preventDefault();
    console.log('Mencari:', searchQuery);
  };

  return (
    <nav className="w-full bg-white border-b border-slate-200 sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-wrap items-center justify-between gap-4 py-3">
          
          {/* Logo DesaKita */}
          <a href="/" className="flex items-center gap-2.5 shrink-0">
            <div className="flex items-center justify-center w-10 h-10 rounded-xl border-2 border-[#13469E] relative bg-blue-50/40">
              <svg
                className="w-6 h-6 text-[#13469E]"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                <path d="M3 6h18" />
                <path d="M16 10a4 4 0 0 1-8 0" />
              </svg>
              <span className="absolute bottom-1.5 w-2.5 h-2.5 bg-emerald-500 rounded-full rounded-tr-none rotate-45" />
            </div>

            <div className="flex flex-col leading-tight">
              <span className="text-xl font-bold tracking-tight">
                <span className="text-[#1E3A5F]">Desa</span>
                <span className="text-[#2563EB]">Kita</span>
              </span>
              <span className="text-[9px] font-semibold tracking-wider text-emerald-700 uppercase">
                Marketplace Komoditas Warga Desa
              </span>
            </div>
          </a>

          {/* Kolom Pencarian */}
          <form
            onSubmit={handleSearch}
            className="order-3 md:order-2 w-full md:flex-1 md:max-w-2xl"
          >
            <div className="relative flex items-center">
              <svg
                className="w-5 h-5 text-slate-600 absolute left-4 pointer-events-none"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
                strokeWidth="2"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="m21 21-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0Z"
                />
              </svg>
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Cari beras organik, jagung pipil, bibit kacang..."
                className="w-full pl-11 pr-4 py-2 text-sm text-slate-800 placeholder-slate-500 bg-[#DCE3F0] border border-slate-400 rounded-full focus:outline-none focus:ring-2 focus:ring-[#13469E] focus:bg-white transition"
              />
            </div>
          </form>

          {/* Tombol Daftar & Masuk */}
          <div className="order-2 md:order-3 flex items-center gap-3 shrink-0">
            <button
              type="button"
              className="px-6 py-2 text-sm font-semibold text-white bg-[#13469E] hover:bg-[#0F3880] rounded-xl transition cursor-pointer"
            >
              Daftar
            </button>
            <button
              type="button"
              className="px-6 py-2 text-sm font-semibold text-white bg-[#13469E] hover:bg-[#0F3880] rounded-xl transition cursor-pointer"
            >
              Masuk
            </button>
          </div>

        </div>
      </div>
    </nav>
  );
}