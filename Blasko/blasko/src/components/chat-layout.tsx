'use client';

import { useState } from 'react';
import { ChatSidebar } from '@/components/chat-sidebar';
import { cn } from '@/lib/utils';

type ChatLayoutProps = {
  children: React.ReactNode;
};

export function ChatLayout({ children }: ChatLayoutProps) {
  const [sidebarOpen, setSidebarOpen] = useState(true);

  return (
    <div className="relative h-screen overflow-hidden">
      <ChatSidebar isOpen={sidebarOpen} onToggle={() => setSidebarOpen(!sidebarOpen)} />
      <main 
        className={cn(
          "h-full transition-all duration-300",
          sidebarOpen ? "ml-64" : "ml-0"
        )}
      >
        {children}
      </main>
    </div>
  );
}

