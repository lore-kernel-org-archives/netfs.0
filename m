Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8528982D
	for <netfs@lists.linux.dev>; Wed,  9 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056792; cv=none; b=haOQTWQ2QFS2iFzUFWFga46WAiC0jY7x07E1N/XjJ101NbHZ59fprpjVBPj+HGi2fJrDWSp/yLXc6spGmp3zC4aPZFFRIXDlck/yYuQ+wlHhR6AM4M3Ana9SPygsHw0tU4WLVGwedLTvdSRXAvZ/c86MRsvCc7R4OwwxhNOrEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056792; c=relaxed/simple;
	bh=wbnVGbjHNz2co8d+fXBHn4JejafVFSAL2G4zjFDrvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egWx+lpa3/lMltN1kQslpTi/BvR6L0sxfMp73tjXDjJ13RTsTpaCvKlJLnhlCX26aicUp2u5JwR1suoHzCmbd4sWlzV62TYPAfvIF+GyApJKcKttsxK85qWZxfpCREEOoz8wTYjYVru4PD8x1T7Te+lNzknYoWQmZ9/0L/HTr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SMoDh0Ci; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SMoDh0Ci"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0de1c378fso825136866b.3
        for <netfs@lists.linux.dev>; Wed, 09 Jul 2025 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752056788; x=1752661588; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=SMoDh0CiQtAKP8ez6Xt+jpQ2grd+sg/yMFKz5npj9ySsMJDy3h2RVIQc2ygfVFq/2h
         96y4snzbHzsRxH5KhVaiv4OFYUAMJLV3hrtJ6ZztbuvhEIHeR0gCJgVa4Wa9wXOrEMzG
         MAlnNgkShUx9IP57J2Sjp4Ae3pkpsgbu0nf+h8SD3hqWWjWL/uUICxhfqjAuN18wgZJY
         pRijqClRpeVP0mkbcedQ+5/BfLlgvNVYmEC7NwJxLV6OyyyFi7sVYTTWtWSTzY/qfekt
         3YhdhWsFdcL+SqDv43mXGW9ySH5W4VhREl5m6DHY3fm0L8I1tCNA9hb5OwhAiSoQN2h5
         AMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056788; x=1752661588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=pu6NS/hqaAl/C+9JVGaeVrSmmZsUe8nRNhkhMmPc2r5+Fn9JLF00FM22CHFfTbVKgJ
         mqhLyI7T9jQ6ghx36F6FB2LAQOA0ldf84vGpdaTmucB/HTQVwStCR0F0lQLQcvTcYtWo
         2N1nfNM2gh/0hG8OFhYIx/vD8Rg3VHzy4+p+jNgjFfwjbDXOgHY54lac9VKJYIac7Z0h
         mpvqQsJCqfhlmceRPF7esCjUew6lAPiTe7LhsciGeHARvbAAVFObiUazI7zB//mv2txt
         H8cKVRzBnnl3+E8uHnfVPk/inOfFsqd3h2HB76UU5K4Ep+Ae9Hp7KWJcnH0rNCAkMYhf
         NjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgyrxoGPEkOxghNmZzDdFDS/iNAaqEiGkIFJ83xS2GqHPN731cIQvKH1ajeZ2RA71N6ANNbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJCmplF/sVhgcGFfJsl8i/KQJCbNBKpD/rcejKWka8yyEClILU
	mGlj44kEB4g923LbCl7me5lKKlrfcYI1Umv6aiMyAFkaXH9l4GO3S+qWG7y4vZBHuKVu/rFy5F9
	KaUc0PyVKR1gSK9mW21hQl5YmjdTz8RMhJKGRxxo+8A==
X-Gm-Gg: ASbGncuEr0PgPPbZJOVDpOhT3DOfeRQbefJ99nNmB8kFE/s3BH4CBvq9AXrvi+bVdUV
	azmpVqdKVHkHadLCODPRWocnGFb1ksHlnJOx7QllQiudUhDQnM3bXzxUwKC5I76YaoYlDh5R0II
	6X+Yeb2LWyLNKdBYE3jvgCWhkhVQXf3UDKzv5oJM8BLUKBbycZhCUAc6bIdO8023p4okQnMdz4O
	ZfLgwgAQg==
X-Google-Smtp-Source: AGHT+IGbqwygDCctWSd13zB7txA8nj1LhT4JGyQ85VQ1ULmFhI635wDH8IR1PaEr0MvmBrrgrCIFH+uxlqg39uXxl9g=
X-Received: by 2002:a17:907:1c15:b0:ae0:bdc2:9957 with SMTP id
 a640c23a62f3a-ae6cfbd985amr185279366b.61.1752056788493; Wed, 09 Jul 2025
 03:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 12:26:17 +0200
X-Gm-Features: Ac12FXwp4fbGLXVwqf6tAOr1y42YQrXGTBI6Q0Kfy3_DmIljAuOKBpuGHKZXSZ0
Message-ID: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Howells <dhowells@redhat.com> wrote:
> Here are some miscellaneous fixes and changes for netfslib and cifs, if you
> could consider pulling them.  All the bugs fixed were observed in cifs, so
> they should probably go through the cifs tree unless Christian would much
> prefer for them to go through the VFS tree.

Hi David,

your commit 2b1424cd131c ("netfs: Fix wait/wake to be consistent about
the waitqueue used") has given me serious headaches; it has caused
outages in our web hosting clusters (yet again - all Linux versions
since 6.9 had serious netfs regressions). Your patch was backported to
6.15 as commit 329ba1cb402a in 6.15.3 (why oh why??), and therefore
the bugs it has caused will be "available" to all Linux stable users.

The problem we had is that writing to certain files never finishes. It
looks like it has to do with the cachefiles subrequest never reporting
completion. (We use Ceph with cachefiles)

I have tried applying the fixes in this pull request, which sounded
promising, but the problem is still there. The only thing that helps
is reverting 2b1424cd131c completely - everything is fine with 6.15.5
plus the revert.

What do you need from me in order to analyze the bug?

Max
