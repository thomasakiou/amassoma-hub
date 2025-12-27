
import React from 'react';
import { VOCABULARY, VIDEO_CLASSES, ICONS } from '../constants';

const LearningHub: React.FC = () => {
  return (
    <div className="space-y-16">
      {/* Header */}
      <div className="text-center max-w-2xl mx-auto">
        <h2 className="text-4xl font-bold mb-4">Izon Learning Hub</h2>
        <p className="text-slate-600">Preserving the Amassoma dialect through interactive digital tools, live sessions, and recorded archives.</p>
      </div>

      {/* Live Classes Section */}
      <section>
        <div className="flex items-center justify-between mb-6">
          <h3 className="text-2xl font-bold flex items-center gap-2">
            <span className="flex h-3 w-3 rounded-full bg-red-500 animate-pulse"></span>
            Live Now & Upcoming
          </h3>
          <button className="text-blue-600 font-bold hover:underline">View Schedule</button>
        </div>
        <div className="bg-gradient-to-r from-blue-600 to-blue-800 rounded-3xl p-8 md:p-12 text-white relative overflow-hidden shadow-xl">
          <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-8">
            <div className="max-w-lg">
              <span className="bg-white/20 px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider mb-4 inline-block">Happening Now</span>
              <h4 className="text-3xl font-bold mb-2">Conversational Amassoma Izon</h4>
              <p className="text-blue-100 mb-6">Join Elder Tariere as he teaches the nuances of everyday greetings and family conversation.</p>
              <div className="flex gap-4">
                <button className="bg-white text-blue-900 font-bold px-6 py-3 rounded-xl hover:bg-blue-50 transition-colors flex items-center gap-2">
                  <ICONS.Video /> Join Live Session
                </button>
                <div className="flex -space-x-3 items-center">
                  {[1, 2, 3].map(i => (
                    <img key={i} src={`https://picsum.photos/seed/user${i}/40/40`} className="w-10 h-10 rounded-full border-2 border-blue-700" alt="Student" />
                  ))}
                  <span className="ml-4 text-sm font-medium">42 others online</span>
                </div>
              </div>
            </div>
            <div className="hidden md:block w-full max-w-xs">
              <div className="bg-black/20 backdrop-blur-md rounded-2xl p-6 border border-white/10">
                <p className="text-xs uppercase font-bold text-blue-200 mb-2">Next Class</p>
                <p className="font-bold">Izon Poetry & Folklore</p>
                <p className="text-sm text-blue-100">Tomorrow @ 10:00 AM</p>
                <button className="mt-4 w-full bg-white/10 hover:bg-white/20 py-2 rounded-lg text-xs font-bold border border-white/20">Remind Me</button>
              </div>
            </div>
          </div>
          {/* Decorative shapes */}
          <div className="absolute -top-24 -right-24 w-64 h-64 bg-white/5 rounded-full blur-3xl"></div>
        </div>
      </section>

      {/* Recorded Video Library */}
      <section>
        <div className="flex items-center justify-between mb-8">
          <h3 className="text-2xl font-bold flex items-center gap-2">
            <ICONS.Video /> Recorded Masterclasses
          </h3>
          <div className="flex gap-2">
            <button className="px-4 py-2 bg-white border border-slate-200 rounded-lg text-sm font-medium hover:bg-slate-50">Newest</button>
            <button className="px-4 py-2 bg-white border border-slate-200 rounded-lg text-sm font-medium hover:bg-slate-50">Popular</button>
          </div>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {VIDEO_CLASSES.map((vid) => (
            <div key={vid.id} className="group cursor-pointer">
              <div className="relative aspect-video rounded-2xl overflow-hidden mb-4 shadow-sm group-hover:shadow-md transition-shadow">
                <img src={vid.thumbnail} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" alt={vid.title} />
                <div className="absolute inset-0 bg-black/20 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                  <div className="w-12 h-12 bg-white rounded-full flex items-center justify-center text-blue-600 shadow-xl">
                    <ICONS.Play />
                  </div>
                </div>
                <div className="absolute bottom-3 right-3 bg-black/70 text-white text-[10px] font-bold px-2 py-1 rounded">
                  {vid.duration}
                </div>
              </div>
              <h4 className="font-bold text-slate-900 group-hover:text-blue-600 transition-colors mb-1">{vid.title}</h4>
              <p className="text-sm text-slate-500">{vid.instructor}</p>
            </div>
          ))}
          {/* Add more placeholder cards to fill grid */}
          <div className="border-2 border-dashed border-slate-200 rounded-2xl flex flex-col items-center justify-center p-8 text-center text-slate-400 aspect-video">
            <ICONS.Video />
            <p className="mt-2 text-sm">More classes being uploaded weekly</p>
          </div>
        </div>
      </section>

      {/* Vocabulary Flashcards */}
      <section>
        <h3 className="text-2xl font-bold mb-8 flex items-center gap-2">
          <ICONS.Language /> Essential Vocabulary
        </h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {VOCABULARY.map((item) => (
            <div key={item.word} className="bg-white p-6 rounded-2xl shadow-sm border border-slate-200 hover:border-blue-300 transition-all group">
              <span className="inline-block px-2 py-1 bg-slate-100 rounded text-[10px] font-bold uppercase text-slate-500 mb-3 tracking-widest group-hover:bg-blue-50 group-hover:text-blue-600 transition-colors">
                {item.category}
              </span>
              <div className="mb-4">
                <h3 className="text-3xl font-bold text-slate-900 mb-1">{item.word}</h3>
                <p className="text-blue-600 font-medium italic text-sm">{item.pronunciation}</p>
              </div>
              <div className="pt-4 border-t border-slate-50">
                <p className="text-slate-500 text-sm">English Translation</p>
                <p className="text-xl font-semibold text-slate-800">{item.translation}</p>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
};

export default LearningHub;
