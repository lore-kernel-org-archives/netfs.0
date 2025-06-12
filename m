Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0741EDA1E
	for <netfs@lists.linux.dev>; Thu, 12 Jun 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708642; cv=none; b=svTv4Zf6aKV6NtPto+MJyjpkOjH7ztSmpVeSHUTDXKmNL3OLWrNjaWbamJqcD+0/fl/pey0aXnhd6Nn3alH6iX4R80NmbXEVqXl7xONfXz89kGyqfLcaqDp7MgMqyuyRNs4VggNitwu65ECfA6aQmQCXFVG7axha7KoouPMAKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708642; c=relaxed/simple;
	bh=A4zc0EMiZ0JUl6RqVV9OyKZA1/ZylTuCgKp6RDdhuI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWdORIQpFgnFZW8uUvGylKCh3bjQdtlvTfuyieNHJPauEyHOMcfCYOdnxWeZpTty7PRR7seUlkSjzk41U+HGMmmJN1WKb1/tDGTuZUMRj1dt9GqPNY7k/Xths+Mf/yi1xUc6O68LB3wcqPhLz3PzA2RAQ10SsfgdT8/jn3Qdx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ILGePjrZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ILGePjrZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d20451c016so32946885a.1
        for <netfs@lists.linux.dev>; Wed, 11 Jun 2025 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749708639; x=1750313439; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O0GS3Xn45yxp2jYxNXPognaFy6v44TiCH4udWlQ/Naw=;
        b=ILGePjrZLF3nMrIHuxTBXYljuP67OpfnQXhGPTNdDwWc0Ey6QACO7I83Sguhhxypqt
         7EmVwubhdUydCz8lfHHmQlG8HKVj0uV3LG4BCDwFeMxCONGta+kJO4DtPGZsm8LD7zZ0
         JSxFL7kch5f7nvEQCRS6XSqbQEG12kHogWcg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708639; x=1750313439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0GS3Xn45yxp2jYxNXPognaFy6v44TiCH4udWlQ/Naw=;
        b=NFX60lP0l/C9kOYypLDc+YrK61OLh2ZhQb60ZLzbQwfZ39UG4FIyJr+tvix7MqWkFN
         zJg4u/o248vGn0jMrNv9Dpgj//lObpK/OlS5FJPO4UZ3H6wBb70gtX+12LXKGq7cToV5
         CcBo6dT28Sdi2whFSlHmQSlXAi8wFc+UBGNoyeGsh1xXwlRPj8+IGWfgSZUTsUUeSsPg
         nypK3n1Mm8gM74B6mvXv4ihinaB5wwPakgYNZVbsr0MToPWygQ+NxSoCCe40F4C1oUx/
         oC2PvMJKVhq98vRfNYzQuqYxv/8cdykJa/FBVOpFzJ9DXNEMENVE6sgwexf2Jkgkw4CS
         eGsw==
X-Forwarded-Encrypted: i=1; AJvYcCXBVF8BzpPgZvqhxN4iHH6yO6g1E2BzT7zO5taRVvI02PYavRHrhLw3rZTgGvM7vvnl3jNevA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5lRsr8TaOgJB05zDHgaM5v77PGZanlx1FMqVA6TVGa9nZnycl
	FWGjEMYdmnLgMXFEpK2bZtmYe1PaNVA5URrtE0GVTnc2SU6FwCv4zE2WTT1nyQeQZnd0Zsogvmv
	SPnci6XzTdyB6E3A0JHrREC0Cljyh3N7hMkCHi5EgXA==
X-Gm-Gg: ASbGncvh1bOhk/ZXKhA7r8Ykgdiy10Xd08c6S/TpZypBz9N+emJVVwebHB++tlUGZ2G
	Yo3DOAH1lX+PsjeNoKvfPQ5Iz5m0Yx9JdG8duvT65NY1LdEL1TC2VGpHItRdNB/qVn0sOIHR/kg
	XvRAY0c10T08qWVXqgi/x7Zqm8o7QNWiHI2Tpn2LLI8rxX
X-Google-Smtp-Source: AGHT+IG8mJ6hovLPfrGSPVZZU8LTl3WPeV6J9EcHeo13rKs+RbYAbWrMSqN0W1KPVIpUi8ZQ5vNJpJ1Y0zewWcBaRQU=
X-Received: by 2002:a05:620a:27cf:b0:7d0:984a:d1b4 with SMTP id
 af79cd13be357-7d3b35ddb5cmr233276985a.17.1749708639529; Wed, 11 Jun 2025
 23:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250611225848.1374929-1-neil@brown.name> <20250611225848.1374929-2-neil@brown.name>
 <20250611233842.GB1647736@ZenIV>
In-Reply-To: <20250611233842.GB1647736@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Jun 2025 08:10:27 +0200
X-Gm-Features: AX0GCFtntii07X6oZYW-zPG_4E3lufAYRQgLIdh6AS0l6bl-_PMPPzxmVgXFsfY
Message-ID: <CAJfpeguiOZJ4dZU-mc0V8bwvWoJ-Q0JubYvYPpmr-f8uguF2LQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 01:38, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Umm...  No objections, as long as overlayfs part is correct; it seems
> to be, but I hadn't checked every chunk there...

Overlayfs parts looks okay too.

A followup would be nice (e.g. make ovl_cleanup() take a dentry for
the directory as well, etc) so that there's no need to have local
variables for both the inode and dentry of the directory.

Thanks,
Miklos
