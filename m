Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D01537D4
	for <netfs@lists.linux.dev>; Fri,  6 Dec 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497745; cv=none; b=TOZWQcmkYT8WLgPjv+OZnf/2+dA/6JGkPReqT0t/EpRpotk6KJw9/9psuMqtesdzj4p7fpEbT11aH9C4O6wyaFSe0Lfv0Omu1EAC+bRB/oPkdLKVyevcQRvRLXC7DgX1zsNMgCdeGJrTaL+Hc8xFAPWI1lZERsE9EhJc0ObJ3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497745; c=relaxed/simple;
	bh=6vi2w3ULnui1L5jZFYYCFPz35j6gLiS6YYBj4J3Ca2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTQ7P4RcJMHPItKtyKKAHy5L44ut37FUd56L7pyB3prkGbG0ZVC9i3LWvxvUqrO+cP66putW8b8Jwod0rGdZ4CYQ0Ly2UGQRSKaE9LLwAPecTLfg7EDLjPJgsDOLj1aopqpQ/flY6EUnRL3+6hbD3c4KCT+cc0yNfDNzUbBVdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P6iofEuC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P6iofEuC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e44654ae3so349215066b.1
        for <netfs@lists.linux.dev>; Fri, 06 Dec 2024 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733497742; x=1734102542; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vi2w3ULnui1L5jZFYYCFPz35j6gLiS6YYBj4J3Ca2M=;
        b=P6iofEuC/f0RwH6EnmGtmZGgL62XimLTOkEZ1WZrH6qRPvzKM2MXPYCuaOTp1/W+pl
         Rlrr+YXy/ipzrmH4Q/pYThRswylAeutaDCbz7UGeR5YPktqgFiSunlbspHPt0E/U34xZ
         0aFX92FWW/iGxE2Ctjga2zLoJ7MPvC7WMvOW4UaVDoDnaYH8J1Q895BCkMRaYHSQmqXs
         Rojqg0gGaJlbVVTTdGXtx8M3l90vRZQ9aVkgoTaJ3s7SQ9MuWW2YZ8BBqPOBw6itljBF
         NwleWO66qh/pEhfaaUMgn+omfQ2etqsI6J5zNRQFnB608JKd0HhVnltDoukuv4KKD2FP
         N3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497742; x=1734102542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vi2w3ULnui1L5jZFYYCFPz35j6gLiS6YYBj4J3Ca2M=;
        b=uCYLD8z6cUar3HxUyjVU13zowx46ftIaSI0Jbj6S23IPnRjqikwtfNw+/AlYL4KIHH
         bEIDj0NSdtTROh4dlyMDFsOKGThdgF75oSwKkYUe4M+WR4ZSrhK7ovvNjtM7qdfHKZkB
         uvYHoWMcDz6/BPM1zrzZfTwc0H1bCmfa7ndpWc1ZOzYXRMf0tS72wsMILCOIRN6z3kwN
         zr8fhiXPAp3GuseSDmlPe69N6tH0Gf1IKYP57RPagLsUMdFXZuqx2uDE4UMzyrrJMX9k
         W87+GEzGoz52NvkDPiyWC1701qPFV1MhC9WJJBRDggZdZgGe4DL5yK4JWo70V+W2o/+q
         KC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFjb39MXcHeFd8oxt2ABZSw2qLI86s+MGbdv6JZBdAjY6dckSbg+meVKfCv2wZA4DsPIhEig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3u6sZWHjHDW725JRBr0t4G527feJ50jviNzZ8kMEQALaSYWnS
	zvqTh5RM/10/Z7bsr0JL11YXdnAUO/q/JrviBt7HuW5G0oXOnL7pzZGWeAcrMRVflZPV0GCNtAn
	DY8oQ+7lMmPXrbjsWDKiTBr5+fntZSLGDxU16QQ==
X-Gm-Gg: ASbGncsRCv95ruyBUG8ovKnnuzzhkePSjPW9iSyJXtUc8SRFW1uLlE+j5kn/jdzOX0d
	v0CRjvvId7tYoqAM7xDbQnHDVdyRI/6qz5HXU+07cC/Zi82OYQTudamurwSBqgych
X-Google-Smtp-Source: AGHT+IEIrl5IoxFJj2C4V6I0kQ3wpU36uB7bQ3fap7ePoneT9UiORfQqEfdtxBsh8Xe1mm/efADKuAobWRxnptVApy4=
X-Received: by 2002:a17:906:9c1:b0:aa6:21ce:cde0 with SMTP id
 a640c23a62f3a-aa639fb2f18mr280779766b.12.1733497741857; Fri, 06 Dec 2024
 07:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
In-Reply-To: <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 16:08:50 +0100
Message-ID: <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:29=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
> I have encountered multiple hangs with that branch; for example:

Similar hangs wth 6.12.2 (vanilla without your "netfs-writeback" branch):

[<0>] folio_wait_bit_common+0x23a/0x4f0
[<0>] folio_wait_private_2+0x37/0x70
[<0>] netfs_invalidate_folio+0x168/0x520
[<0>] truncate_cleanup_folio+0x281/0x340
[<0>] truncate_inode_pages_range+0x1bb/0x780
[<0>] ceph_evict_inode+0x17e/0x6b0
[<0>] evict+0x331/0x780
[<0>] __dentry_kill+0x17b/0x4f0
[<0>] dput+0x2a6/0x4a0
[<0>] __fput+0x36d/0x910
[<0>] __x64_sys_close+0x78/0xd0
[<0>] do_syscall_64+0x64/0x100
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

netfs in 6.12 remains pretty broken, both with and without your fixes.

The sad thing is that 6.11 has just been EOLed. Linux 6.6 is the only
sane kernel.
