
import React, { useState } from 'react';
import { ICONS } from './constants';
import { View } from './types';
import NewsBlog from './components/NewsBlog';
import History from './components/History';
import LearningHub from './components/LearningHub';
import Translator from './components/Translator';
import Community from './components/Community';

const App: React.FC = () => {
  const [currentView, setCurrentView] = useState<View>('home');

  const renderView = () => {
    switch (currentView) {
      case 'home':
        return (
          <div className="space-y-12">
            <section className="relative h-[500px] rounded-3xl overflow-hidden shadow-2xl">
              <img 
                src="https://picsum.photos/seed/delta/1200/600" 
                className="absolute inset-0 w-full h-full object-cover" 
                alt="Amassoma" 
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent flex flex-col justify-end p-8 md:p-16">
                <h1 className="text-4xl md:text-6xl font-bold text-white mb-4">Amassoma Hub</h1>
                <p className="text-lg md:text-xl text-slate-200 max-w-2xl mb-8 leading-relaxed">
                  The heartbeat of Southern Ijaw. A place for the Amassoma people to learn, grow, and connect with their heritage.
                </p>
                <div className="flex flex-wrap gap-4">
                  <button 
                    onClick={() => setCurrentView('language')}
                    className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-xl transition-colors shadow-lg shadow-blue-900/40"
                  >
                    Start Learning Izon
                  </button>
                  <button 
                    onClick={() => setCurrentView('history')}
                    className="bg-white/10 hover:bg-white/20 backdrop-blur-md text-white border border-white/30 font-bold py-3 px-8 rounded-xl transition-colors"
                  >
                    Explore History
                  </button>
                </div>
              </div>
            </section>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
              <div className="lg:col-span-2 space-y-12">
                <NewsBlog />
              </div>
              <div className="space-y-8">
                <Translator />
                <div className="bg-white rounded-2xl shadow-sm p-6 border border-slate-200">
                  <h3 className="text-xl font-bold mb-4 flex items-center gap-2">
                    <ICONS.Community /> Community Pulse
                  </h3>
                  <p className="text-slate-600 text-sm mb-4">See what people are debating about today.</p>
                  <button 
                    onClick={() => setCurrentView('community')}
                    className="w-full bg-slate-100 hover:bg-slate-200 text-slate-900 font-bold py-3 rounded-xl transition-colors"
                  >
                    Join the Conversation
                  </button>
                </div>
              </div>
            </div>
          </div>
        );
      case 'history': return <History />;
      case 'language': return <LearningHub />;
      case 'news': return <NewsBlog />;
      case 'community': return <Community />;
      default: return <div>View not found</div>;
    }
  };

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Navigation */}
      <nav className="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-slate-100 px-4 md:px-8 py-4">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <div 
            className="flex items-center gap-2 cursor-pointer group"
            onClick={() => setCurrentView('home')}
          >
            <div className="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center text-white font-bold text-xl group-hover:rotate-6 transition-transform">
              A
            </div>
            <span className="text-xl font-bold tracking-tight hidden sm:block">Amassoma<span className="text-blue-600">Hub</span></span>
          </div>

          <div className="flex items-center gap-2 md:gap-6">
            <NavItem 
              active={currentView === 'home'} 
              onClick={() => setCurrentView('home')} 
              icon={<ICONS.Home />} 
              label="Home" 
            />
            <NavItem 
              active={currentView === 'history'} 
              onClick={() => setCurrentView('history')} 
              icon={<ICONS.History />} 
              label="History" 
            />
            <NavItem 
              active={currentView === 'language'} 
              onClick={() => setCurrentView('language')} 
              icon={<ICONS.Language />} 
              label="Learn" 
            />
            <NavItem 
              active={currentView === 'community'} 
              onClick={() => setCurrentView('community')} 
              icon={<ICONS.Community />} 
              label="Debates" 
            />
          </div>

          <div className="hidden md:flex items-center gap-4">
            <button className="text-sm font-semibold text-slate-600 hover:text-blue-600">Sign In</button>
            <button className="bg-blue-600 text-white text-sm font-bold px-5 py-2 rounded-full hover:bg-blue-700 transition-colors">Join Community</button>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 md:px-8 py-8 md:py-12">
        {renderView()}
      </main>

      {/* Footer */}
      <footer className="bg-slate-900 text-slate-400 py-12 px-4 mt-20">
        <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-4 gap-12">
          <div className="md:col-span-1">
            <div className="flex items-center gap-2 text-white font-bold text-xl mb-4">
              <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">A</div>
              AmassomaHub
            </div>
            <p className="text-sm leading-relaxed">
              Preserving our heritage, uniting our people, and building a digital gateway for the Amassoma community.
            </p>
          </div>
          <div>
            <h4 className="text-white font-bold mb-4 uppercase text-xs tracking-widest">Resources</h4>
            <ul className="space-y-2 text-sm">
              <li><button onClick={() => setCurrentView('language')} className="hover:text-white transition-colors">Izon Language Classes</button></li>
              <li><button onClick={() => setCurrentView('history')} className="hover:text-white transition-colors">Historical Archives</button></li>
              <li><button onClick={() => setCurrentView('news')} className="hover:text-white transition-colors">NDU Updates</button></li>
            </ul>
          </div>
          <div>
            <h4 className="text-white font-bold mb-4 uppercase text-xs tracking-widest">Community</h4>
            <ul className="space-y-2 text-sm">
              <li><button onClick={() => setCurrentView('community')} className="hover:text-white transition-colors">Forum Debates</button></li>
              <li><a href="#" className="hover:text-white transition-colors">Events Calendar</a></li>
              <li><a href="#" className="hover:text-white transition-colors">Local Directory</a></li>
            </ul>
          </div>
          <div>
            <h4 className="text-white font-bold mb-4 uppercase text-xs tracking-widest">Contact</h4>
            <ul className="space-y-2 text-sm">
              <li>Amassoma Town, Southern Ijaw</li>
              <li>Bayelsa State, Nigeria</li>
              <li>contact@amassomahub.org</li>
            </ul>
          </div>
        </div>
        <div className="max-w-7xl mx-auto border-t border-slate-800 mt-12 pt-8 flex flex-col md:flex-row justify-between items-center gap-4 text-xs">
          <p>© 2024 Amassoma Hub. All Rights Reserved.</p>
          <div className="flex gap-6">
            <a href="#" className="hover:text-white">Privacy Policy</a>
            <a href="#" className="hover:text-white">Terms of Service</a>
          </div>
        </div>
      </footer>
    </div>
  );
};

interface NavItemProps {
  active: boolean;
  onClick: () => void;
  icon: React.ReactNode;
  label: string;
}

const NavItem: React.FC<NavItemProps> = ({ active, onClick, icon, label }) => (
  <button 
    onClick={onClick}
    className={`flex items-center gap-2 px-3 py-2 rounded-lg font-medium text-sm transition-all ${
      active 
        ? 'bg-blue-50 text-blue-600' 
        : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900'
    }`}
  >
    {icon}
    <span className="hidden lg:inline">{label}</span>
  </button>
);

export default App;
