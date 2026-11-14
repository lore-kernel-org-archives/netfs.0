Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794649335;
	b=JEetZKUTqfpEM/jtCqKdhDEjchxYHpAuYsxkNzEXCekdGksXTSUO0ZUXAyYgMz0w6bm+
	 IIhxTpNy4qR5xclO8z86Dt/6X5We/a4kvDdPu1w7mFBTNyZ6iZi22/YTLziE9uY6wfMtf
	 KhlkRIMhnTou/jS32m+42Qr7s6VJ0l+8Is903HagUYnxEnZbJ10Yu30jNEQN7IQk4quxV
	 jih/6LFzFeqx8cD7VtSa5m7SCfz/T7DIHT2CYDO/j4pdtFplW+ut8SJQK++wfZAc49awZ
	 NG7cMP7k4NkyoGuj1J/dbyG/R6V7Uzfw5YdccfNRXn7SeMVshic82mqMEZIrvuvj0KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794649335;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=pIGPIFBWZWXbATAlZfCud1WRKu4IF0iJVD7JMKvXy3k=;
	b=lwi8yvFyhG1DEvgJDeouoda6r1TF+33P1Zv6mwDEMYytUuBnfgbz2Md/f30n+q+b/ieu
	 2iQtOxyg2wCN61YaodbsWwN1ADu9x0We95YCg5uVlj5PUaR9b7ur/gfDAfXWz3gZ0QdG7
	 8xe+R1/sL5X2gBu//inlHukLOrV5v8LWVa9clET6p2C0u67m6c96bBYnW6bNLVhVWEGpl
	 PoI0sg7iki4ayOnRwj2L0DfwKJ7kh53rwvjwXZtIvoXQDp934UK9KCYaqHRI/M3c8aCtj
	 VPKoNKH706p9ddN6d3jpRXc+tC1hP/aPamwRQz/XbAA0/y4aYCnklH15LShYJase1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WAtNUQ/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A7606A327;
	Sat, 14 Nov 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAtNUQ/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A651F000C4;
	Sat, 14 Nov 2026 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794649334;
	bh=pIGPIFBWZWXbATAlZfCud1WRKu4IF0iJVD7JMKvXy3k=;
	h=Date:From:To:Cc:Subject;
	b=WAtNUQ/zCoSrc5CtT9ENLWfPqfjaFnMPxfkd76t7U0TKG7tJa+edV+Aux29yphSYJ
	 V1lxgo3iFEII6bPcWj61hVlauDB3LQCayNQqjxYX8YhZ4wEucZSHBuO4qQI/SxKeMJ
	 cGFZkiDilgz3tsMvMlipk42LiDa5jRR7zIZcMKDoIYRA2ycl19L8ELQWpcMpjG+lAw
	 HembcyEj31tbDPDXdAMconldGvFJrBKdaqUMXIIGgtHw5NCCGCkUk4SSc+2cot9DXJ
	 KhWW2usp2QxZns2uVpmwRDvGDppeAa66WwbnJpRdJ2ZuhTx+KfJZX7Q2aAwkq2/zTX
	 2rdyi+uXFtFwg==
Date: Sat, 14 Nov 2026 10:42:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jan Kara <jack@suse.cz>, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: cachefiles: cache objects get created on a frozen cache filesystem
Message-ID: <20261114-hingen-unannehmbar-gelage-7397ef6d8e33@brauner>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

I'm working on freeze protection fixes across the tree and this one I
just can't fix myself.

cachefiles only takes freeze protection around its xattr updates since
80887f316729 ("cachefiles: Fix non-taking of sb_writers around
set/removexattr"). The namespace operations on the cache filesystem
still don't have it. So cachefiles modifies a frozen cache filesystem.
On ext4 that trips the WARN_ON() in ext4_journal_check_start().

Reproduced on v7.4-rc1 with the cache on ext4, bound through
/dev/cachefiles, and an NFS mount with -o fsc. Freeze the cache
filesystem and read files through NFS that aren't cached yet:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#2: kworker/u16:1/43
  Workqueue: fscache fscache_cookie_worker
  Call Trace:
   __ext4_journal_start_sb+0x7a/0x470
   __ext4_new_inode+0x23da/0x45d0
   ext4_tmpfile+0x1b9/0x490
   vfs_tmpfile+0x414/0xa90
   kernel_tmpfile_open+0x3d/0x70
   cachefiles_create_tmpfile+0x1c7/0x800
   cachefiles_create_file+0x6f/0x2f0
   cachefiles_look_up_object+0x71a/0x8a0
   cachefiles_lookup_cookie+0x3b8/0x8f0
   fscache_cookie_worker+0xa23/0x19a0
   process_one_work+0x946/0x1820
   worker_thread+0x4f1/0xd60
   kthread+0x364/0x460

That's one per file read.

From reading the code the other namespace operations have the same
problem but I've only triggered the tmpfile creation:

- vfs_mkdir() in cachefiles_get_directory()
- vfs_rename() in cachefiles_bury_object()
- vfs_unlink() in cachefiles_unlink()
- vfs_link() in cachefiles_commit_tmpfile()

They need mnt_want_write(cache->mnt) taken before the parent's inode
lock, like the xattr helpers do it.

The tmpfile creation goes back to 1f08c925e7a3 ("cachefiles: Implement
backing file wrangling").
