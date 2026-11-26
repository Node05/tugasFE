import React from 'react';

const categories = [
  {
    id: 'makanan-minuman',
    title: 'Makanan/Minuman',
    // Bisa diganti dengan import gambar lokal dari src/assets/ kalau sudah ada
    image:
      'src/assets/imagemakanan.png',
  },
  {
    id: 'pertanian',
    title: 'Pertanian',
    image:
      'src/assets/imagepertanian.jpeg',
  },
  {
    id: 'peternakan',
    title: 'Peternakan',
    image:
      'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 'kerajinan',
    title: 'Kerajinan',
    image:
      'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=600&q=80',
  },
  {
    id: 'jasa',
    title: 'Jasa',
    image:
      'https://images.unsplash.com/photo-1500937386664-56d1dfef3854?auto=format&fit=crop&w=600&q=80',
  },
];

export default function KategoriUnggulan({ onSelectCategory }) {
  return (
    <section className="w-full bg-[#F8FAFC] py-12 md:py-16">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        {/* Header Section */}
        <div>
          <p className="text-xs font-medium text-slate-600">
            Kategori Unggulan
          </p>
          <h2 className="mt-1 text-2xl sm:text-3xl font-bold text-[#0F9D8A] tracking-tight">
            Temukan Kategori Unggulan
          </h2>
          <p className="mt-2 text-xs sm:text-sm text-slate-600">
            Pilih kategori untuk melihat produk yang sesuai dengan kebutuhan Anda.
          </p>
        </div>

        {/* Grid 5 Kartu Kategori */}
        <div className="mt-8 grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-4 sm:gap-5">
          {categories.map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => onSelectCategory?.(item)}
              className="group flex flex-col rounded-xl overflow-hidden bg-white shadow-sm hover:shadow-md transition text-left cursor-pointer"
            >
              {/* Foto Kategori */}
              <div className="w-full aspect-square overflow-hidden bg-slate-200">
                <img
                  src={item.image}
                  alt={item.title}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                />
              </div>

              {/* Bar Label Biru di Bawah */}
              <div className="w-full bg-[#113F7C] group-hover:bg-[#0D3263] py-3.5 px-2 text-center transition-colors">
                <span className="text-xs sm:text-sm font-semibold text-white">
                  {item.title}
                </span>
              </div>
            </button>
          ))}
        </div>

      </div>
    </section>
  );
}