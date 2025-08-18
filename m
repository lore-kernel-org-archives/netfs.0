Received: from thor.imp.ch (thor.imp.ch [157.161.4.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15D334708;
	Mon, 18 Aug 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.161.4.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523120; cv=none; b=DyNyRVMQYvcx2/UpNp4LqufPBMDrz6ckm4P7KlFNY8hn4fsbI6SAgzLzlkiX+VvZAt9fZtolEyoYqjjj2RhNySjjLaQ5bnZbX7WJk1MfyBNBVZGZO98n38EL5JPk6L99scAeaBIZRjXhANRosCdWqcMHhmZJP6d27WBCvKD2A3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523120; c=relaxed/simple;
	bh=By96cjTuNZjb6N982SGqiWCH6ewfg4bvR6HPHWbInio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTFgRzzU1cLYeKyEcapn3Rq0iZ3C/C1tPelgdj4OnqbmxFrVHJuze1BpNbxcN1DO65U/3hD6i9HFHTsp9xC3Xy6xOv91clrSBZfJSFwzo+Wpq5af34Z3mW1h53NuifW3M9ZmQ0SbjG5gyOTIJYiT+9IQz+e/UMcEa7HwAI2t6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch; spf=pass smtp.mailfrom=imp.ch; dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b=VK586F9x; arc=none smtp.client-ip=157.161.4.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imp.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b="VK586F9x"
Received: from go.imp.ch (go.imp.ch [IPv6:2001:4060:1:4133:f8d3:e3ff:fee7:5808])
	by thor.imp.ch (8.18.1/8.13.3) with ESMTPS id 57IDIEB4067261
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 18 Aug 2025 15:18:14 +0200 (CEST)
	(envelope-from benoit.panizzon@imp.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imp.ch; s=mail;
	t=1755523095; bh=By96cjTuNZjb6N982SGqiWCH6ewfg4bvR6HPHWbInio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VK586F9xL2Tk1VVUA4sKWlizoCjv5OVasNy6G3VWIx+ZKP4u3ro/pY7IfVK7xKtCB
	 jGnLQWr5FshJQVEYTXovnHfRLvUS4K5B7Hc7x/fghHWNGv2/VjWO3neczr1rz43pGy
	 e9FBfeMgO29RFzkDdn8R/aqwKkYbq6G1cnA8nkHk=
Date: Mon, 18 Aug 2025 15:18:14 +0200
From: Benoit Panizzon <benoit.panizzon@imp.ch>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
        David Howells
 <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benoit Panizzon <bp@imp.ch>, 1111455@bugs.debian.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [bp@imp.ch: Bug#1111455: linux-image-6.12.41+deb13-amd64:
 kernel BUG at fs/netfs/read_collect.c:316 netfs: Can't donate prior to
 front]
Message-ID: <20250818151814.18d5dcd4@go.imp.ch>
In-Reply-To: <aKMdIgkSWw9koCPC@eldamar.lan>
References: <aKMdIgkSWw9koCPC@eldamar.lan>
Organization: ImproWare AG
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Salvatore

> A user in Debian reported the following kernel oops when running on
> 6.12.41 (but apparently as well on older versions, though there were
> several netfs related similar issues, so including Max Kellermann as
> well in the recipients)

Thanks for looking into this issue. 6.1 from bookworm did not crash
since this morning.

Installed 6.16 from debian experimental - just the linux-image package.

Linux go 6.16-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.16.1-1~exp1 (2025-08-16=
) x86_64 GNU/Linux

Running cachefilesd, /home on NFS

25 minutes uptime. 6.12 would for have oopsed before. Mostly in the
first 5 minutes.

I have upgraded several machines from Bookworm to Trixie - some make
use of NFS but none as heavily as my office workstation with /home on
NFS. All the other machines are either on ARM or INTEL metal or
virtualised KVM machines. Not seen that issue on those other machines.

I suspect it could be a problem affecting only that specific CPU indeed
hitting an invalid opcode.

vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 PRO 5750GE with Radeon Graphics
stepping	: 0
microcode	: 0xa500011

Mit freundlichen Gr=C3=BCssen

-Beno=C3=AEt Panizzon-
--=20
I m p r o W a r e   A G    -    Leiter Commerce Kunden
______________________________________________________

Zurlindenstrasse 29             Tel  +41 61 826 93 00
CH-4133 Pratteln                Fax  +41 61 826 93 01
Schweiz                         Web  http://www.imp.ch
______________________________________________________
