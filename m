Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A1152166
	for <netfs@lists.linux.dev>; Wed,  4 Sep 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484361; cv=none; b=TVVBmtghK44j5AduLamVonJrKUO9TrgsSZB+VhfYmdZ9UF12ncCaWtLJuyMiIN1lMMlLnixO3w8btZsinlpEQADTQRJy5QujNkALy6RMJxA7miHyvrUH6LbnQblj5+RuI5hFIOC4YWbfs1GtAzd0fjdktFB26+30YJMjfbbx750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484361; c=relaxed/simple;
	bh=guLfzvzHe/Ar8KjiPmsJlEXy+TxFLF80tnd+JVKmu0E=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AAoRky2DvocdNG2M9p5LMdDEz6AhASjCWpo9bF0+JovZDzCsMChpETlssae/iwg5WpBtAdbHRx+zZSJWWsV7MVlo/MjTgmjOHBGuKGAtl8yMnyacGVsrHq4s14g4bSyuUstRHL6xG62qnDWZbgEG/sIkJcqJyLJubKGa2f4Yhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-189-85.static.sonic.net (192-184-189-85.static.sonic.net [192.184.189.85])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 484L28aW000373;
	Wed, 4 Sep 2024 14:02:08 -0700
From: Forest <forestix@nom.one>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] cifs: triggers bad flatpak & ostree signatures, corrupts ffmpeg & mkvmerge outputs
Date: Wed, 04 Sep 2024 14:02:08 -0700
Message-ID: <1dihdj9avrsvritngbtie92i5udsf28168@sonic.net>
References: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
In-Reply-To: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVbf6qhAFZ29YVsyvEy6C+n4FasBrjvR+o3aEgrO/1vOqvbzlOlEcb+NyztygbtXqMYqLA8TJlo1h/NIWayd8fSz
X-Sonic-ID: C;1leg8gBr7xGvzM+N3bHVhw== M;Igyv8gBr7xGvzM+N3bHVhw==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Sat, 24 Aug 2024 18:50:40 -0700, Forest wrote:

>I think I have found a cifs regression in the 6.10 kernel series, which leads
>certain programs to write corrupt data.
[...]
>3ee1a1fc39819906f04d6c62c180e760cd3a689d is the first bad commit

Write corruption still exists in 6.11.0-rc6.

Bad ostree signatures may be fixed in 6.11.0-rc6. (My reproducer didn't
trigger it in that version.)
