import React from 'react';

const stores = [
  {
    id: 1,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 2,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 3,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 4,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 5,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 6,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 7,
    name: 'Nasi Gurih Dua Putra',
    description: 'Kedai nasi gurih terenak se-Tulungagung',
    rating: 5,
    image:
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80',
  },
];

export default function TokoUnggulan({ onSelectStore }) {
  return (
    <section className="w-full bg-[#F8FAFC] py-12 md:py-16">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        {/* Header Section */}
        <div>
          <p className="text-xs font-medium text-slate-600">
            Toko Unggulan
          </p>
          <h2 className="mt-1 text-2xl sm:text-3xl font-bold text-[#0F9D8A] tracking-tight">
            Temukan Toko Lokal Terbaik
          </h2>
          <p className="mt-2 text-xs sm:text-sm text-slate-600">
            Pilih toko yang menarik untuk Anda.
          </p>
        </div>

        {/* Grid Kartu Toko (4 kolom di desktop) */}
        <div className="mt-8 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
          {stores.map((store) => (
            <div
              key={store.id}
              className="group bg-white rounded-2xl border border-slate-200 shadow-sm hover:shadow-md transition overflow-hidden flex flex-col"
            >
              {/* Foto Toko */}
              <div className="w-full aspect-4/3 overflow-hidden bg-slate-200">
                <img
                  src={store.image}
                  alt={store.name}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                />
              </div>

              {/* Konten Kartu */}
              <div className="p-4 flex flex-col flex-1">
                {/* Rating 5 Bintang */}
                <div className="flex items-center gap-0.5">
                  {Array.from({ length: 5 }).map((_, index) => (
                    <svg
                      key={index}
                      className={`w-4 h-4 ${
                        index < store.rating ? 'text-amber-400' : 'text-slate-300'
                      }`}
                      fill="currentColor"
                      viewBox="0 0 20 20"
                    >
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                  ))}
                </div>

                {/* Nama & Deskripsi Toko */}
                <h3 className="mt-2 text-base font-bold text-slate-900">
                  {store.name}
                </h3>
                <p className="mt-1 text-xs text-slate-600 leading-relaxed">
                  {store.description}
                </p>

                {/* Tombol Lihat Toko di Kanan Bawah */}
                <div className="mt-auto pt-5 flex justify-end">
                  <button
                    type="button"
                    onClick={() => onSelectStore?.(store)}
                    className="inline-flex items-center gap-1.5 px-4 py-1.5 text-xs font-semibold text-white bg-[#13469E] hover:bg-[#0F3880] rounded-full transition cursor-pointer"
                  >
                    <span>Lihat Toko</span>
                    <svg
                      className="w-3.5 h-3.5"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                      strokeWidth="2.2"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3"
                      />
                    </svg>
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
}